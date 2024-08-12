with Interfaces.C;
use Interfaces.C;
with System;

package Chipmunk
  with Preelaborate
is

   subtype cpFloat is Interfaces.C.double;

   function Infinity return cpFloat;
   pragma Import (C, Infinity, "cpFloat_inf");

   subtype cpBool is Interfaces.C.C_bool;

   type cpCollisionType is new Interfaces.C.unsigned;
   subtype cpDataPointer is System.Address;
   subtype cpTimestamp is Interfaces.C.unsigned;
   subtype cpBitmask is Interfaces.C.unsigned;

   type cpBodyType is (Dynamic, Kinematic, Static) with Convention => C;

   type cpBody is new System.Address;

   type cpShape is new System.Address;
   subtype cpCircleShape is cpShape;
   subtype cpSegmentShape is cpShape;
   subtype cpPolyShape is cpShape;

   type cpConstraint is new System.Address;
   subtype cpDampedSpring is cpConstraint;
   subtype cpDampedRotarySpring is cpConstraint;
   subtype cpPivotJoint is cpConstraint;
   subtype cpPinJoint is cpConstraint;
   subtype cpGearJoint is cpConstraint;
   subtype cpSlideJoint is cpConstraint;
   subtype cpSimpleMotor is cpConstraint;
   subtype cpRatchetJoint is cpConstraint;
   subtype cpRotaryLimitJoint is cpConstraint;
   subtype cpGrooveJoint is cpConstraint;

   type cpArbiter is new System.Address;
   type cpSpace is new System.Address;
   type cpShapeFilter is new System.Address;

   type cpContactPointSet is new System.Address;

   type cpCollisionBeginFunc is
     access function
       (Arb : cpArbiter; Space : cpSpace; User_Data : cpDataPointer)
        return cpBool
   with Convention => C;
   --  Collision begin event function callback type. Returning false from a
   --  begin callback causes the collision to be ignored until the the separate
   --  callback is called when the objects stop colliding.

   type cpCollisionPreSolveFunc is
     access function
       (Arb : cpArbiter; Space : cpSpace; User_Data : cpDataPointer)
        return cpBool
   with Convention => C;
   --  Collision pre-solve event function callback type. Returning false from
   --  a pre-step callback causes the collision to be ignored until the next
   --  step.

   type cpCollisionPostSolveFunc is
     access procedure
       (Arb : cpArbiter; Space : cpSpace; User_Data : cpDataPointer)
   with Convention => C;
   --  Collision post-solve event function callback type.

   type cpCollisionSeparateFunc is
     access procedure
       (Arb : cpArbiter; Space : cpSpace; User_Data : cpDataPointer)
   with Convention => C;
   --  Collision separate event function callback type.

   --  Struct that holds function callback pointers to configure custom
   --  collision handling. Collision handlers have a pair of types; when a
   --  collision occurs between two shapes that have these types, the collision
   --  handler functions are triggered.
   type cpCollisionHandler is record
      --  Collision type identifier of the first shape that this handler
      --  recognizes. In the collision handler callback, the shape with
      --  this type will be the first argument. Read only.
      typeA : cpCollisionType;

      --  Collision type identifier of the second shape that this handler
      --  recognizes. In the collision handler callback, the shape with
      --  this type will be the second argument. Read only.
      typeB : cpCollisionType;

      --  This function is called when two shapes with types that match this
      --  collision handler begin colliding.
      beginFunc : cpCollisionBeginFunc;

      --  This function is called each step when two shapes with types that
      --  match this collision handler are colliding. It's called before the
      --  collision solver runs so that you can affect a collision's outcome.
      preSolveFunc : cpCollisionPreSolveFunc;

      --  This function is called each step when two shapes with types that
      --  match this collision handler are colliding. It's called after the
      --  collision solver runs so that you can read back information about
      --  the collision to trigger events in your game.
      postSolveFunc : cpCollisionPostSolveFunc;

      --  This function is called when two shapes with types that match this
      --  collision handler stop colliding.
      separateFunc : cpCollisionSeparateFunc;

      --  This is a user definable context pointer that is passed to all of the
      --  collision handler functions.
      userData : cpDataPointer;
   end record
   with Convention => C_Pass_By_Copy;

   type cpGroup is new System.Address;

   type cpPointQueryInfo is new System.Address;
   type cpSegmentQueryInfo is new System.Address;
   type cpBB is new System.Address;

   type cpVect is record
      X, Y : cpFloat;
   end record
   with Convention => C_Pass_By_Copy;

   type C_cpVect_Array is array (Interfaces.C.unsigned) of cpVect
   with Convention => C;

   type cpTransform is record
      A, B, C, D, TX, TY : cpFloat;
   end record
   with Convention => C_Pass_By_Copy;

   type cpMat2x2 is record
      A, B, C, D : cpFloat;
   end record
   with Convention => C_Pass_By_Copy;

   type cpSpaceDebugColor is record
      R, G, B, A : C_float;
   end record
   with Convention => C_Pass_By_Copy;

   type cpSpaceDebugDrawFlags is new Interfaces.Unsigned_16;
   DEBUG_DRAW_SHAPES           : constant cpSpaceDebugDrawFlags := 2#0001#;
   DEBUG_DRAW_CONSTRAINTS      : constant cpSpaceDebugDrawFlags := 2#0010#;
   DEBUG_DRAW_COLLISION_POINTS : constant cpSpaceDebugDrawFlags := 2#0100#;

   function cpMomentForCircle
     (Mass, R1, R2 : cpFloat; Offset : cpVect) return cpFloat;
   pragma Import (C, cpMomentForCircle, "cpMomentForCircle");

   function cpAreaForCircle (R1, R2 : cpFloat) return cpFloat;
   pragma Import (C, cpAreaForCircle, "cpAreaForCircle");

   function cpMomentForSegment
     (Mass : cpFloat; A, B : cpVect; Radius : cpFloat) return cpFloat;
   pragma Import (C, cpMomentForSegment, "cpMomentForSegment");

   function cpAreaForSegment (A, B : cpVect; Radius : cpFloat) return cpFloat;
   pragma Import (C, cpAreaForSegment, "cpAreaForSegment");

   function cpMomentForPoly
     (Mass   : cpFloat;
      Count  : Interfaces.C.int;
      verts  : access C_cpVect_Array;
      Offset : cpVect;
      Radius : cpFloat) return cpFloat;
   pragma Import (C, cpMomentForPoly, "cpMomentForPoly");

   function cpAreaForPoly
     (Count  : Interfaces.C.int;
      verts  : access C_cpVect_Array;
      Radius : cpFloat) return cpFloat;
   pragma Import (C, cpAreaForPoly, "cpAreaForSegment");

   function cpCentroidForPoly
     (Count : Interfaces.C.int; verts : access C_cpVect_Array) return cpVect;
   pragma Import (C, cpCentroidForPoly, "cpCentroidForSegment");

   function cpMomentForBox (Mass, Width, Height : cpFloat) return cpFloat;
   pragma Import (C, cpMomentForBox, "cpMomentForBox");

end Chipmunk;
