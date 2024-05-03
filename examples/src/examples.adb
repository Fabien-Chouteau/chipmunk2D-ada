with Interfaces.C; use Interfaces.C;

with Chipmunk; use Chipmunk;
with Chipmunk.Arbiters;
with Chipmunk.Bodies; use Chipmunk.Bodies;
with Chipmunk.Spaces; use Chipmunk.Spaces;
with Chipmunk.Shapes; use Chipmunk.Shapes;
with Chipmunk.PolyShapes;
with Chipmunk.Damped_Springs; use Chipmunk.Damped_Springs;
with Chipmunk.Groove_Joints; use Chipmunk.Groove_Joints;
with Chipmunk_Raylib_Debug;

with Raylib; use Raylib;

with Ada.Containers.Doubly_Linked_Lists;
with Ada.Real_Time; use Ada.Real_Time;
with Chipmunk.Pin_Joints; use Chipmunk.Pin_Joints;
with Chipmunk.Simple_Motors; use Chipmunk.Simple_Motors;
with Chipmunk.Constraints; use Chipmunk.Constraints;
with Chipmunk.Damped_Rotary_Springs; use Chipmunk.Damped_Rotary_Springs;
with Chipmunk.Pivot_Joints; use Chipmunk.Pivot_Joints;
with Chipmunk.Rotary_Limit_Joints; use Chipmunk.Rotary_Limit_Joints;

procedure Examples is
   pragma Suppress_All;
   pragma Style_Checks ("M120");

   Space : constant cpSpace := cpSpaceNew;

   Width  : constant := 800;
   Height : constant := 600;

   type Object_Kind is (Bouncy_Ball, Heavy_Ball, Medium_Box);
   type Object_Data is record
      Kind : Object_Kind;
      Bod  : cpBody;
   end record;
   package Body_Lists is new Ada.Containers.Doubly_Linked_Lists (Object_Data);

   Objects : Body_Lists.List;
   --  Object_Color : constant array (Object_Kind) of Raylib.Color :=
   --    (Bouncy_Ball => GREEN,
   --     Heavy_Ball  => RED,
   --     Medium_Box  => VIOLET);

   Ball_Size : constant := 10.0;
   Box_Size : constant := 30.0;

   procedure Add_Object (X, Y : C_float; Kind : Object_Kind) is
      Bod : cpBody;
      Shape : cpShape;

      Mass : constant cpFloat := (case Kind is
                                     when Bouncy_Ball => 10.0,
                                     when Heavy_Ball  => 100.0,
                                     when Medium_Box  => 50.0);
      Moment : constant cpFloat := (case Kind is
                                       when Bouncy_Ball => 50.0,
                                       when Heavy_Ball  => 300.0,
                                       when Medium_Box  => 50.0);
      Elasticity : constant cpFloat := (case Kind is
                                           when Bouncy_Ball => 1.0,
                                           when Heavy_Ball  => 0.3,
                                           when Medium_Box  => 0.6);
      Friction : constant cpFloat := (case Kind is
                                         when Bouncy_Ball => 0.3,
                                         when Heavy_Ball  => 1.0,
                                         when Medium_Box  => 100.0);
   begin
      Bod := cpBodyNew (Mass, Moment);
      cpBodySetPosition (Bod, (cpFloat (X), cpFloat (Y)));
      Bod := cpSpaceAddBody (Space, Bod);

      case Kind is
         when Bouncy_Ball | Heavy_Ball =>
            Shape := cpCircleShapeNew (Bod, Ball_Size, (0.0, 0.0));
            cpShapeSetElasticity (Shape, Elasticity);
            cpShapeSetFriction (Shape, Friction);
            cpShapeSetCollisionType (Shape, 1);
            cpBodySetAngularVelocity (Bod, 1000.0);
         when Medium_Box =>
            Shape := PolyShapes.cpBoxShapeNew (Bod, Box_Size, Box_Size, 1.0);
            cpBodySetAngularVelocity (Bod, 1000.0);
      end case;

      Shape := cpSpaceAddShape (Space, Shape);
      pragma Unreferenced (Shape);

      Objects.Append ((Kind, Bod));
   end Add_Object;

   procedure Add_Couple (X, Y : C_float) is
      C : cpConstraint;
      A, B : cpBody;
   begin
      Add_Object (X + 10.0, Y, Object_Kind'First);
      A := Objects.Last_Element.Bod;

      Add_Object (X - 10.0, Y, Object_Kind'Last);
      B := Objects.Last_Element.Bod;

      C := cpDampedSpringNew (A, B, (0.0, 0.0), (0.0, 0.0),
                              restLength => 100.0,
                              stiffness => 50.0,
                              damping => 1.0);
      C := cpSpaceAddConstraint (Space, C);

      pragma Unreferenced (C);
   end Add_Couple;

   type Segment_Data is record
      A, B : cpVect;
      Radius : cpFloat;
      Bod : cpBody;
   end record;

   package Segment_Lists
   is new Ada.Containers.Doubly_Linked_Lists (Segment_Data);

   Segments : Segment_Lists.List;

   procedure Add_Segment (A, B : cpVect; Radius : cpFloat) is
      Segment_Body : cpBody;
      Segment_Shape : cpShape;
   begin
      Segment_Body := cpBodyNew (0.0, Infinity);
      cpBodySetType (Segment_Body, Static);
      cpBodySetPosition (Segment_Body, (0.0, 0.0));
      Segment_Body := cpSpaceAddBody (Space, Segment_Body);

      Segment_Shape := cpSegmentShapeNew
        (Segment_Body, A, B, Radius);
      cpShapeSetElasticity (Segment_Shape, 0.5);
      cpShapeSetFriction (Segment_Shape, 100.0);
      cpShapeSetCollisionType (Segment_Shape, 1);

      Segment_Shape := cpSpaceAddShape (Space, Segment_Shape);

      Segments.Append ((A, B, Radius, Segment_Body));
   end Add_Segment;

   Head_Radius : constant := 17.5 / 2.0;
   Torso_Len    : constant := 50.0;
   Arm_U_Len  : constant := 30.0;
   Arm_L_Len  : constant := 32.0;
   Leg_U_Len  : constant := 46.0;
   Leg_L_Len  : constant := 45.0;

   Knee, Hip, Unused_Neck, Unused_Shoulder, Elbow : cpConstraint;

   Shoulder_Range     : constant := 3.14 * 1.0;
   Shoulder_Min_Angle : constant := -3.14 * 0.5;
   Shoulder_Max_Angle : constant := Shoulder_Min_Angle + Shoulder_Range;

   Elbow_Range     : constant := 3.14 * 0.9;
   Elbow_Min_Angle : constant := 3.14 * 0.0;
   Elbow_Max_Angle : constant := Elbow_Min_Angle + Elbow_Range;

   Hip_Range     : constant := 3.14 * 0.8;
   Hip_Min_Angle : constant := 3.14 * 0.0;
   Hip_Max_Angle : constant := Hip_Min_Angle + Hip_Range;

   Knee_Range     : constant := 3.14 * 0.8;
   Knee_Min_Angle : constant := -Knee_Range;
   Knee_Max_Angle : constant := Knee_Min_Angle + Knee_Range;

   Head_Collision_Type : constant := 42;

   Head, Torso, Arm_L, Arm_U, Leg_L, Leg_U : cpBody;

   subtype Posture_Range is cpFloat range 0.0 .. 1.0;

   procedure Set_Ragdoll_Posture (Elbow_P, Hip_P, Knee_P : Posture_Range) is
   begin
      cpDampedRotarySpringSetRestAngle
        (Elbow, -(Elbow_Min_Angle + Elbow_Range * Elbow_P));
      cpDampedRotarySpringSetRestAngle
        (Hip, -(Hip_Min_Angle + Hip_Range * Hip_P));
      cpDampedRotarySpringSetRestAngle
        (Knee, -(Knee_Min_Angle + Knee_Range * Knee_P));
   end Set_Ragdoll_Posture;

   -----------------------
   -- HeadPostSolveFunc --
   -----------------------

   procedure HeadPostSolveFunc (Arb : cpArbiter;
                                Space : cpSpace;
                                User_Data : cpDataPointer)
     with Convention => C;

   procedure HeadPostSolveFunc (Arb : cpArbiter;
                                Space : cpSpace;
                                User_Data : cpDataPointer)
   is
      pragma Unreferenced (Space, User_Data);
      use Chipmunk.Arbiters;
      A, B : aliased cpBody;
   begin
      cpArbiterGetBodies (Arb, A'Access, B'Access);
      --  Put_Line ("--- Head Post Solve ---");
      --  Put_Line ("Surface Velocity X" & cpArbiterGetSurfaceVelocity (Arb).X'Img);
      --  Put_Line ("Surface Velocity Y " & cpArbiterGetSurfaceVelocity (Arb).Y'Img);
      --  Put_Line ("Restitution: " & cpArbiterGetRestitution (Arb)'Img);
      --  Put_Line ("Total Impulse X:" & cpArbiterTotalImpulse (Arb).X'Img);
      --  Put_Line ("Total Impulse Y:" & cpArbiterTotalImpulse (Arb).Y'Img);
      --  Put_Line ("Count " & cpArbiterGetCount (Arb)'Img);
   end HeadPostSolveFunc;

   function HeadPreSolveFunc (Arb : cpArbiter;
                              Space : cpSpace;
                              User_Data : cpDataPointer)
                              return cpBool
     with Convention => C;

   function HeadPreSolveFunc (Arb : cpArbiter;
                              Space : cpSpace;
                              User_Data : cpDataPointer)
                              return cpBool
   is
      pragma Unreferenced (Space, User_Data);
      use Chipmunk.Arbiters;
      A, B : aliased cpBody;
   begin
      cpArbiterGetBodies (Arb, A'Access, B'Access);
      --  Put_Line ("--- Head Pre Solve ---");
      --  Put_Line ("Surface Velocity X" & cpArbiterGetSurfaceVelocity (Arb).X'Img);
      --  Put_Line ("Surface Velocity Y " & cpArbiterGetSurfaceVelocity (Arb).Y'Img);
      --  Put_Line ("Restitution: " & cpArbiterGetRestitution (Arb)'Img);
      --  Put_Line ("Total Impulse X:" & cpArbiterTotalImpulse (Arb).X'Img);
      --  Put_Line ("Total Impulse Y:" & cpArbiterTotalImpulse (Arb).Y'Img);
      --  Put_Line ("Count " & cpArbiterGetCount (Arb)'Img);
      return True;
   end HeadPreSolveFunc;

   procedure Add_Ragdoll is

      S_Head, S_Torso, S_Arm_L, S_Arm_U, S_Leg_L, S_Leg_U : cpShape;

      Total_Mass : constant := 60.0;

      Offset : constant cpVect := (100.0, 240.0);

      Head_Mass   : constant := Total_Mass * 0.083;
      Head_Moment : constant cpFloat :=
        cpMomentForCircle (Head_Mass, Head_Radius, 0.0, (0.0, 0.0));
      Head_Pos    : constant cpVect := (Offset.X, Offset.Y);

      Torso_Mass   : constant := Total_Mass * 0.5415;
      Torso_W      : constant := Head_Radius * 0.8;
      Torso_Moment : constant cpFloat :=
        cpMomentForBox (Torso_Mass, Torso_W, Torso_Len);
      Torso_Pos    : constant cpVect :=
        (Head_Pos.X,
         Head_Pos.Y - Head_Radius);

      Arm_U_Mass : constant := Total_Mass * 0.030;
      Arm_U_W    : constant := Torso_W * 0.5;
      Arm_U_Moment : constant cpFloat :=
        cpMomentForBox (Arm_U_Mass, Arm_U_W, Arm_U_Len);
      Arm_U_Pos    : constant cpVect := Torso_Pos;

      Arm_L_Mass : constant := Total_Mass * 0.0172;
      Arm_L_W    : constant := Torso_W * 0.4;
      Arm_L_Moment : constant cpFloat :=
        cpMomentForBox (Arm_L_Mass, Arm_L_W, Arm_L_Len);
      Arm_L_Pos    : constant cpVect :=
        (Arm_U_Pos.X + Arm_U_Len, Arm_U_Pos.Y);

      Leg_U_Mass : constant := Total_Mass * 0.1112;
      Leg_U_W    : constant := Torso_W * 0.7;
      Leg_U_Moment : constant cpFloat :=
        cpMomentForBox (Leg_U_Mass, Leg_U_W, Leg_U_Len);
      Leg_U_Pos    : constant cpVect :=
        (Torso_Pos.X, Torso_Pos.Y - Torso_Len);

      Leg_L_Mass : constant := Total_Mass * 0.050;
      Leg_L_W    : constant := Torso_W * 0.6;
      Leg_L_Moment : constant cpFloat :=
        cpMomentForBox (Leg_L_Mass, Leg_L_W, Leg_L_Len);
      Leg_L_Pos    : constant cpVect :=
        (Leg_U_Pos.X, Leg_U_Pos.Y - Leg_U_Len);

      C, Unused : cpConstraint;

   begin
      --  Head
      Head := cpSpaceAddBody (Space, cpBodyNew (Head_Mass, Head_Moment));
      cpBodySetPosition (Head, Head_Pos);
      S_Head := cpSpaceAddShape (Space,
                                 cpCircleShapeNew (Head, Head_Radius,
                                   (0.0, 0.0)));
      cpShapeSetCollisionType (S_Head, Head_Collision_Type);

      --  Torso
      Torso := cpSpaceAddBody (Space, cpBodyNew (Torso_Mass, Torso_Moment));
      cpBodySetPosition (Torso, Torso_Pos);
      S_Torso := cpSpaceAddShape (Space,
                                  cpSegmentShapeNew (Torso,
                                    (0.0, 0.0),
                                    (0.0, -Torso_Len),
                                    Torso_W / 2.0));

      --  Head to Torso
      C := cpSpaceAddConstraint
        (Space, cpPivotJointNew2 (Head, Torso,
         (0.0, -Head_Radius * 1.3),
         (0.0, Head_Radius * 0.3)));
      cpConstraintSetCollideBodies (C, False);
      Unused_Neck := cpSpaceAddConstraint (Space,
                                    cpDampedRotarySpringNew (Head, Torso,
                                      restAngle => 0.0,
                                      stiffness => 500000.0,
                                      damping => 100.0
                                     )
                                   );

      --  Upper Arm
      Arm_U := cpSpaceAddBody (Space, cpBodyNew (Arm_U_Mass, Arm_U_Moment));
      cpBodySetPosition (Arm_U, Arm_U_Pos);
      S_Arm_U := cpSpaceAddShape (Space,
                                  cpSegmentShapeNew (Arm_U,
                                    (0.0, 0.0),
                                    (Arm_U_Len, 0.0),
                                    Arm_U_W / 2.0));

      --  Torso to Upper Arm
      C := cpSpaceAddConstraint
        (Space, cpPivotJointNew (Torso, Arm_U, Torso_Pos));
      cpConstraintSetCollideBodies (C, False);
      --  Shoulder := cpSpaceAddConstraint (Space,
      --                             cpDampedRotarySpringNew (Torso, Arm_U,
      --                                      restAngle => 0.0,
      --                                      stiffness => 10000.0,
      --                                      damping => 10.0
      --                                     )
      --                                   );
      Unused := cpSpaceAddConstraint (Space,
                                      cpRotaryLimitJointNew (Torso, Arm_U,
                                        Shoulder_Min_Angle,
                                        Shoulder_Max_Angle));

      --  Lower Arm
      Arm_L := cpSpaceAddBody (Space, cpBodyNew (Arm_L_Mass, Arm_L_Moment));
      cpBodySetPosition (Arm_L, Arm_L_Pos);
      S_Arm_L := cpSpaceAddShape (Space,
                                  cpSegmentShapeNew (Arm_L,
                                    (0.0, 0.0),
                                    (Arm_L_Len, 0.0),
                                    Arm_L_W / 2.0));

      --  Upper Arm to Lower Arm
      C := cpSpaceAddConstraint
        (Space, cpPivotJointNew (Arm_U, Arm_L, Arm_L_Pos));
      cpConstraintSetCollideBodies (C, False);
      Elbow := cpSpaceAddConstraint (Space,
                                     cpDampedRotarySpringNew (Arm_U, Arm_L,
                                       restAngle => 0.0,
                                       stiffness => 1000000.0,
                                       damping => 100.0
                                      )
                                    );
      Unused := cpSpaceAddConstraint (Space,
                                      cpRotaryLimitJointNew (Arm_U, Arm_L,
                                        Elbow_Min_Angle,
                                        Elbow_Max_Angle));

      --  Upper Leg
      Leg_U := cpSpaceAddBody (Space, cpBodyNew (Leg_U_Mass, Leg_U_Moment));
      cpBodySetPosition (Leg_U, Leg_U_Pos);
      S_Leg_U := cpSpaceAddShape (Space,
                                  cpSegmentShapeNew (Leg_U,
                                    (0.0, 0.0),
                                    (0.0, -Leg_L_Len),
                                    Leg_U_W / 2.0));

      --  Torso to Upper Leg
      C := cpSpaceAddConstraint
        (Space, cpPivotJointNew (Torso, Leg_U, Leg_U_Pos));
      cpConstraintSetCollideBodies (C, False);
      Hip := cpSpaceAddConstraint (Space,
                                   cpDampedRotarySpringNew (Torso, Leg_U,
                                     restAngle => -3.14 * 0.5,
                                     stiffness => 5000000.0,
                                     damping => 100.0
                                    )
                                  );
      Unused := cpSpaceAddConstraint (Space,
                                      cpRotaryLimitJointNew (Torso, Leg_U,
                                        Hip_Min_Angle,
                                        Hip_Max_Angle));

      --  Lower Leg
      Leg_L := cpSpaceAddBody (Space, cpBodyNew (Leg_L_Mass, Leg_L_Moment));
      cpBodySetPosition (Leg_L, Leg_L_Pos);
      S_Leg_L := cpSpaceAddShape (Space,
                                  cpSegmentShapeNew (Leg_L,
                                    (0.0, 0.0),
                                    (0.0, -Leg_L_Len),
                                    Leg_L_W / 2.0));

      --  Upper Leg to Lower Leg
      C := cpSpaceAddConstraint
        (Space, cpPivotJointNew (Leg_U, Leg_L, Leg_L_Pos));
      cpConstraintSetCollideBodies (C, False);
      Knee := cpSpaceAddConstraint (Space,
                                    cpDampedRotarySpringNew (Leg_U, Leg_L,
                                      restAngle => 3.14 * 0.5,
                                      stiffness => 5000000.0,
                                      damping => 100.0
                                     )
                                   );
      Unused := cpSpaceAddConstraint (Space,
                                      cpRotaryLimitJointNew (Leg_U, Leg_L,
                                        Knee_Min_Angle,
                                        Knee_Max_Angle));

      cpShapeSetFriction (S_Head, 0.7);
      cpShapeSetFriction (S_Torso, 0.7);
      cpShapeSetFriction (S_Arm_U, 0.7);
      cpShapeSetFriction (S_Arm_L, 0.7);
      cpShapeSetFriction (S_Leg_U, 0.7);
      cpShapeSetFriction (S_Leg_L, 0.7);

      declare
         Test : constant access cpCollisionHandler :=
           cpSpaceAddWildcardHandler (Space, Head_Collision_Type);
      begin
         Test.postSolveFunc :=  HeadPostSolveFunc'Unrestricted_Access;
         Test.preSolveFunc := HeadPreSolveFunc'Unrestricted_Access;
      end;

   end Add_Ragdoll;

   Motor : cpConstraint;

   procedure Add_Bike is

      Wheel_Base : constant := 130.0;

      Width : constant := Wheel_Base;
      Height : constant := 50.0;
      Radius : constant := 55.0 / 2.0;

      Total_Mass : constant := 68.0;
      Wheel_Mass : constant := 6.0;
      Chassis_Mass : constant := Total_Mass - 2.0 * Wheel_Mass;

      Offset : constant cpVect := (100.0, 50.0);

      FW_B, RW_B, B_B : cpBody;
      FW_S, RW_S, Unused_Handle_S : cpShape;

      Unused : cpConstraint;
      C : cpConstraint;

      Wheel_Moment : constant cpFloat :=
        cpMomentForCircle (Wheel_Mass, 0.0, Radius, (0.0, 0.0));

      Chassis_Moment : constant cpFloat :=
        cpMomentForBox (Chassis_Mass, Width, Height);
   begin
      FW_B := cpSpaceAddBody (Space, cpBodyNew (Wheel_Mass, Wheel_Moment));
      RW_B := cpSpaceAddBody (Space, cpBodyNew (Wheel_Mass, Wheel_Moment));
      B_B := cpSpaceAddBody (Space, cpBodyNew (Chassis_Mass, Chassis_Moment));

      cpBodySetPosition (B_B,  (Offset.X,                    Offset.Y + 100.0));
      cpBodySetPosition (FW_B, (Offset.X + Wheel_Base / 2.0, Offset.Y + 60.0));
      cpBodySetPosition (RW_B, (Offset.X - Wheel_Base / 2.0, Offset.Y + 60.0));

      FW_S := cpSpaceAddShape (Space,
                               cpCircleShapeNew (FW_B, Radius, (0.0, 0.0)));
      cpShapeSetCollisionType (FW_S, 1);
      cpShapeSetFriction (FW_S, 0.7);
      cpShapeSetElasticity (FW_S, 0.0);

      RW_S := cpSpaceAddShape (Space,
                               cpCircleShapeNew (RW_B, Radius, (0.0, 0.0)));
      cpShapeSetCollisionType (RW_S, 1);
      cpShapeSetFriction (RW_S, 0.7);
      cpShapeSetElasticity (RW_S, 0.0);

      --  B_S := cpSpaceAddShape (Space, Chipmunk.PolyShapes.cpBoxShapeNew (B_B, Width, Height, 0.0));
      --  B_S := cpSpaceAddShape (Space,
      --                          cpSegmentShapeNew
      --                            (B_B,
      --                             (-Width / 2.0, Height),
      --                             (Width / 2.0, Height),
      --                             Height / 2.0));
      --  cpShapeSetCollisionType (B_S, 2);

      --  Front wheel
      Unused := cpSpaceAddConstraint
        (Space,
         cpGrooveJointNew (B_B, FW_B,
           (Wheel_Base * 0.38, 0.0),
           (Wheel_Base * 0.50, -50.0),
           (0.0, 0.0)));
      Unused := cpSpaceAddConstraint
        (Space,
         cpDampedSpringNew (B_B, FW_B,
           (Wheel_Base * 0.38, 0.0),
           (0.0, 0.0),
           restLength => 40.0,
           stiffness  => 10000.0,
           damping    => 100.0));

      --  Rear wheel
      Unused := cpSpaceAddConstraint
        (Space,
         cpPinJointNew (B_B, RW_B,
           (-Wheel_Base * 0.2, -30.0),
           (0.0, 0.0)));
      Unused := cpSpaceAddConstraint
        (Space,
         cpDampedSpringNew (B_B, RW_B,
           (-Wheel_Base * 0.5, -Radius * 1.2),
           (0.0, 0.0),
           restLength => 0.0,
           stiffness => 10000.0,
           damping => 100.0));
      --  Unused := cpSpaceAddConstraint
      --    (Space,
      --     cpSlideJointNew (B_B, RW_B, (-20.0, 0.0), (0.0, 0.0), 10.0, 40.0));

      Motor := cpSpaceAddConstraint
        (Space, cpSimpleMotorNew (B_B, RW_B, 0.0));

      declare
         Handle_Radius : constant := 15.0;
      begin
         Unused_Handle_S := cpSpaceAddShape
           (Space,
            cpCircleShapeNew (B_B,
              Handle_Radius,
              (Wheel_Base * 0.25, 30.0 - Handle_Radius)));
      end;

      --  Hand on handle
      C := cpSpaceAddConstraint
        (Space, cpPivotJointNew2 (B_B, Arm_L,
         (Wheel_Base * 0.25, 30.0),
         (Arm_L_Len, 0.0)));
      cpConstraintSetCollideBodies (C, False);

      --  Foot on footrest
      C := cpSpaceAddConstraint
        (Space, cpPivotJointNew2 (B_B, Leg_L,
         (-Wheel_Base * 0.2, -30.0),
         (0.0, -Leg_L_Len)));
      cpConstraintSetCollideBodies (C, False);
   end Add_Bike;

   function To_Debug (Pos : cpVect) return Raylib.Vector2 is
   begin
      return (C_float (Pos.X), C_float (Height) - C_float (Pos.Y));
   end To_Debug;

   package Debug is new Chipmunk_Raylib_Debug (To_Debug);

   Period : constant Ada.Real_Time.Time_Span :=
     Ada.Real_Time.Milliseconds (1000 / 60);

   Next_Release : Ada.Real_Time.Time;
begin

   Raylib.InitWindow (Width, Height, "Chipmunk Example");

   cpSpaceSetIterations (Space, 10);
   cpSpaceSetGravity (Space, (0.0, -900.0));
   cpSpaceSetSleepTimeThreshold (Space, 0.5);

   Add_Segment ((cpFloat (Width) * 0.0, cpFloat (Height) * 0.0),
                (cpFloat (Width) * 1.0, cpFloat (Height) * 0.0),
                2.0);
   Add_Segment ((cpFloat (Width) * 0.0, cpFloat (Height) * 0.0),
                (cpFloat (Width) * 0.0, cpFloat (Height) * 1.0),
                2.0);
   Add_Segment ((cpFloat (Width) * 1.0, cpFloat (Height) * 1.0),
                (cpFloat (Width) * 1.0, cpFloat (Height) * 0.0),
                2.0);
   Add_Segment ((cpFloat (Width) * 1.0, cpFloat (Height) * 1.0),
                (cpFloat (Width) * 0.0, cpFloat (Height) * 1.0),
                2.0);

   Add_Segment ((cpFloat (Width) * 0.2, cpFloat (Height) * 0.5),
                (cpFloat (Width) * 0.3, cpFloat (Height) * 0.5),
                2.0);
   Add_Segment ((cpFloat (Width) * 0.3, cpFloat (Height) * 0.5),
                (cpFloat (Width) * 0.4, cpFloat (Height) * 0.4),
                2.0);
   Add_Segment ((cpFloat (Width) * 0.4, cpFloat (Height) * 0.4),
                (cpFloat (Width) * 0.45, cpFloat (Height) * 0.4),
                2.0);

   Add_Segment ((cpFloat (Width) * 0.55, cpFloat (Height) * 0.4),
                (cpFloat (Width) * 0.6, cpFloat (Height) * 0.4),
                2.0);
   Add_Segment ((cpFloat (Width) * 0.6, cpFloat (Height) * 0.4),
                (cpFloat (Width) * 0.7, cpFloat (Height) * 0.5),
                2.0);
   Add_Segment ((cpFloat (Width) * 0.7, cpFloat (Height) * 0.5),
                (cpFloat (Width) * 0.8, cpFloat (Height) * 0.5),
                2.0);

   Add_Segment ((cpFloat (Width) * 0.2, cpFloat (Height) * 0.0),
                (cpFloat (Width) * 0.3, cpFloat (Height) * 0.05),
                2.0);

   Add_Segment ((cpFloat (Width) * 0.5, cpFloat (Height) * 0.0),
                (cpFloat (Width) * 0.5, cpFloat (Height) * 0.1),
                2.0);

   Add_Segment ((cpFloat (Width) * 0.5, cpFloat (Height) * 0.1),
                (cpFloat (Width) * 0.6, cpFloat (Height) * 0.1),
                2.0);

   Add_Segment ((cpFloat (Width) * 0.6, cpFloat (Height) * 0.0),
                (cpFloat (Width) * 0.6, cpFloat (Height) * 0.1),
                2.0);

   --  Add_Object (250.0, 300.0, Bouncy_Ball);
   --  Add_Object (280.0, 310.0, Heavy_Ball);

   Add_Ragdoll;
   Add_Bike;

   Next_Release := Ada.Real_Time.Clock + Period;

   while not WindowShouldClose loop

      delay until Next_Release;
      Next_Release := Next_Release + Period;

      if IsMouseButtonPressed (MOUSE_BUTTON_LEFT) then
         Add_Object (GetMousePosition.x,
                   C_float (Height) - GetMousePosition.y,
                   Bouncy_Ball);
      end if;
      if IsMouseButtonPressed (MOUSE_BUTTON_RIGHT) then
         Add_Object (GetMousePosition.x,
                   C_float (Height) - GetMousePosition.y,
                   Heavy_Ball);
      end if;
      if IsMouseButtonPressed (MOUSE_BUTTON_MIDDLE) then
         Add_Couple (GetMousePosition.x,
                     C_float (Height) - GetMousePosition.y);
      end if;

      if IsKeyDown (KEY_UP) then
         cpSimpleMotorSetRate (Motor, 10.0);
      elsif IsKeyDown (KEY_DOWN) then
         cpSimpleMotorSetRate (Motor, -10.0);
      else
         cpSimpleMotorSetRate (Motor, 0.0);
      end if;

      if IsKeyDown (KEY_RIGHT) then
         Set_Ragdoll_Posture (Elbow_P => 0.8,
                              Hip_P   => 0.1,
                              Knee_P  => 1.0);
      elsif IsKeyDown (KEY_LEFT) then
         Set_Ragdoll_Posture (Elbow_P => 0.0,
                              Hip_P   => 1.0,
                              Knee_P  => 1.0);
      else
         Set_Ragdoll_Posture (Elbow_P => 0.5,
                              Hip_P   => 0.5,
                              Knee_P  => 0.5);
      end if;

      cpSpaceStep (Space, 1.0 / 60.0);

      BeginDrawing;
      ClearBackground (BLACK);
      Debug.Draw_Debug (Space);
      Raylib.DrawFPS (0, 0);
      EndDrawing;
   end loop;

   CloseWindow;
end Examples;
