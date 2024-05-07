with System;

with Interfaces.C; use Interfaces.C;

with Chipmunk; use Chipmunk;
with Chipmunk.Bodies; use Chipmunk.Bodies;
with Chipmunk.Spaces; use Chipmunk.Spaces;
with Chipmunk.Shapes; use Chipmunk.Shapes;
with Chipmunk.Arbiters;
with Chipmunk_Raylib_Debug;

with Raylib; use Raylib;
with Raylib.GUI;
with Resources;
with Examples_Config;

with Ada.Containers.Doubly_Linked_Lists;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Numerics.Discrete_Random;

procedure Watermelon is
   pragma Suppress_All;
   pragma Style_Checks ("M120");

   package Game_Resources
   is new Resources (Examples_Config.Crate_Name);

   Space : constant cpSpace := NewSpace;

   Width  : constant := 800;
   Height : constant := 600;

   type Object_Kind is (Cherry, Grape, Strawberry, Orange, Apple, Pear,
                        Dekopon, Peach, Pineapple, Melon, Watermelon);

   subtype Drop_Object_Kind is Object_Kind range Object_Kind'First .. Pear;
   package Random_Object is new Ada.Numerics.Discrete_Random (Drop_Object_Kind);
   Obj_Gen : Random_Object.Generator;

   Base_Radius       : constant := 6.0;
   Cherry_Radius     : constant := Base_Radius       * 1.4;
   Grape_Radius      : constant := Cherry_Radius     * 1.4;
   Strawberry_Radius : constant := Grape_Radius      * 1.4;
   Orange_Radius     : constant := Strawberry_Radius * 1.4;
   Apple_Radius      : constant := Orange_Radius     * 1.4;
   Pear_Radius       : constant := Apple_Radius      * 1.4;
   Dekopon_Radius    : constant := Pear_Radius       * 1.3;
   Peach_Radius      : constant := Dekopon_Radius    * 1.3;
   Pineapple_Radius  : constant := Peach_Radius      * 1.3;
   Melon_Radius      : constant := Pineapple_Radius  * 1.2;
   Watermelon_Radius : constant := Melon_Radius      * 1.2;

   Radius : constant array (Object_Kind) of cpFloat :=
     (Cherry      => Cherry_Radius,
      Grape       => Grape_Radius,
      Strawberry  => Strawberry_Radius,
      Orange      => Orange_Radius,
      Apple       => Apple_Radius,
      Pear        => Pear_Radius,
      Dekopon     => Dekopon_Radius,
      Peach       => Peach_Radius,
      Pineapple   => Pineapple_Radius,
      Melon       => Melon_Radius,
      Watermelon  => Watermelon_Radius);

   Points : constant array (Object_Kind) of Natural :=
     (Cherry      => 1,
      Grape       => 3,
      Strawberry  => 6,
      Orange      => 10,
      Apple       => 15,
      Pear        => 21,
      Dekopon     => 28,
      Peach       => 36,
      Pineapple   => 45,
      Melon       => 55,
      Watermelon  => 66);

   function Mass (Kind : Object_Kind) return cpFloat
   is (cpAreaForCircle (Radius (Kind), 0.0));

   function Moment (Kind : Object_Kind) return cpFloat
   is (cpMomentForCircle (Mass (Kind), Radius (Kind), 0.0, (0.0, 0.0)));

   function Elasticity (Kind : Object_Kind) return cpFloat
   is (case Kind is
          when others => 0.5);

   function Friction (Kind : Object_Kind) return cpFloat
   is (case Kind is
          when others => 0.5);

   function Image_File (Kind : Object_Kind) return String
   is (case Kind is
          when Watermelon => "ada_logo.png",
          when Cherry => "CPlusPlus.png",
          when Grape => "OCaml.png",
          when Melon => "Fortran.png",
          when Orange => "Lua.png",
          when Apple => "CSharp.png",
          when Peach => "PHP.png",
          when Dekopon => "Python.png",
          when Pineapple => "Ruby.png",
          when Strawberry => "Rust.png",
          when Pear => "Swift.png");

   Images : array (Object_Kind) of Raylib.Image;
   Textures : array (Object_Kind) of Raylib.Texture;

   type Merge_Data is record
      Kind : Object_Kind;
      A, B : cpShape;
   end record;

   package Merge_Lists is new Ada.Containers.Doubly_Linked_Lists (Merge_Data);

   Bodies_To_Merge : Merge_Lists.List;

   --  Object_Color : constant array (Object_Kind) of Raylib.Color :=
   --    (Bouncy_Ball => GREEN,
   --     Heavy_Ball  => RED,
   --     Medium_Box  => VIOLET);

   procedure Add_Object (X, Y : cpFloat; Kind : Object_Kind) is
      Bod : cpBody;
      Shape : cpShape;
   begin
      Bod := NewBody (Mass (Kind), Moment (Kind));
      SetPosition (Bod, (X, Y));
      Bod := AddBody (Space, Bod);

      Shape := cpCircleShapeNew (Bod, Radius (Kind), (0.0, 0.0));
      SetElasticity (Shape, Elasticity (Kind));
      SetFriction (Shape, Friction (Kind));
      SetCollisionType (Shape, Kind'Enum_Rep);

      Shape := AddShape (Space, Shape);
      pragma Unreferenced (Shape);
   end Add_Object;

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
      Segment_Body := NewBody (0.0, Infinity);
      SetType (Segment_Body, Static);
      SetPosition (Segment_Body, (0.0, 0.0));
      Segment_Body := AddBody (Space, Segment_Body);

      Segment_Shape := cpSegmentShapeNew (Segment_Body, A, B, Radius);
      SetElasticity (Segment_Shape, 0.5);
      SetFriction (Segment_Shape, 100.0);
      SetCollisionType (Segment_Shape, Object_Kind'Last'Enum_Rep + 1);

      Segment_Shape := AddShape (Space, Segment_Shape);

      Segments.Append ((A, B, Radius, Segment_Body));
   end Add_Segment;

   -------------------
   -- PostSolveFunc --
   -------------------

   procedure PostSolveFunc (Arb : cpArbiter;
                            Space : cpSpace;
                            User_Data : cpDataPointer)
     with Convention => C;

   procedure PostSolveFunc (Arb : cpArbiter;
                            Space : cpSpace;
                            User_Data : cpDataPointer)
   is
      pragma Unreferenced (Space, User_Data);
      use Chipmunk.Arbiters;
      A, B : aliased cpShape;
   begin
      GetShapes (Arb, A'Access, B'Access);
      declare
         K : constant Object_Kind :=
           Object_Kind'Enum_Val (GetCollisionType (A));
      begin
         Bodies_To_Merge.Append ((K, A, B));
      end;
   end PostSolveFunc;

   -----------------
   -- Draw_Object --
   -----------------

   procedure Draw_Object (Kind : Object_Kind; Pos : cpVect; Angle : cpFloat) is
      Tex : Texture renames Textures (Kind);
      Rad : constant C_float := C_float (Radius (Kind));
   begin
      DrawTexturePro (Tex,
                      source => (0.0, 0.0,
                                 C_float (Tex.width), C_float (Tex.height)),
                      dest =>  (C_float (Pos.X),
                                C_float (Height) - C_float (Pos.Y),
                                Rad * 2.0,
                                Rad * 2.0),
                      origin => (Rad, Rad),
                      rotation => -C_float (Angle) * 45.0,
                      tint =>  Raylib.WHITE);
   end Draw_Object;

   Gameover : Boolean := False;
   Score : Natural := 0;

   --------------------
   -- For_Each_Shape --
   --------------------

   procedure For_Each_Shape (Shape : cpShape; Data : cpDataPointer)
     with Convention => C;

   procedure For_Each_Shape (Shape : cpShape; Data : cpDataPointer) is
      pragma Unreferenced (Data);
      Bod : constant cpBody := GetBody (Shape);
      Pos : constant cpVect := GetPosition (Bod);
      Kind : constant Object_Kind :=
        Object_Kind'Enum_Val (GetCollisionType (Shape));
   begin
      if Pos.Y < -20.0 then
         Gameover := True;
      end if;

      Draw_Object (Kind, Pos, GetAngle (Bod));
   end For_Each_Shape;

   function To_Debug (Pos : cpVect) return Raylib.Vector2 is
   begin
      return (C_float (Pos.X), C_float (Height) - C_float (Pos.Y));
   end To_Debug;

   package Debug is new Chipmunk_Raylib_Debug (To_Debug);
   pragma Unreferenced (Debug);

   Next_To_Drop  : Object_Kind := Object_Kind'First;
   Drop_Timeout  : Ada.Real_Time.Time := Ada.Real_Time.Clock;
   Drop_Height   : constant cpFloat := cpFloat (Height) - 40.0;
   Drop_Interval : constant Ada.Real_Time.Time_Span :=
     Ada.Real_Time.Milliseconds (300);

   procedure Setup_Game is
      package Shape_Lists is new Ada.Containers.Doubly_Linked_Lists (cpShape);

      Shape_List : Shape_Lists.List;

      procedure List_Each_Shape (Shape : cpShape; Data : cpDataPointer)
        with Convention => C;

      procedure List_Each_Shape (Shape : cpShape; Data : cpDataPointer) is
         pragma Unreferenced (Data);
      begin
         Shape_List.Append (Shape);
      end List_Each_Shape;

   begin
      Score := 0;
      Next_To_Drop := Object_Kind'First;
      Drop_Timeout := Ada.Real_Time.Clock;
      Gameover := False;
      Random_Object.Reset (Obj_Gen);

      --  Cleanup space
      EachShape (Space, List_Each_Shape'Unrestricted_Access,
                        System.Null_Address);
      for Shape of Shape_List loop
         declare
            Bod : constant cpBody := GetBody (Shape);
         begin
            RemoveShape (Space, Shape);
            RemoveBody (Space, Bod);
            Destroy (Shape);
            Destroy (Bod);
         end;
      end loop;

      --  Set borders
      Add_Segment ((cpFloat (Width) * 0.25, -50.0),
                   (cpFloat (Width) * 0.75, -50.0),
                   60.0);
      Add_Segment ((cpFloat (Width) * 0.25, cpFloat (Height) * 0.0),
                   (cpFloat (Width) * 0.25, cpFloat (Height) * 0.8),
                   5.0);
      Add_Segment ((cpFloat (Width) * 0.75, cpFloat (Height) * 0.8),
                   (cpFloat (Width) * 0.75, cpFloat (Height) * 0.0),
                   5.0);
   end Setup_Game;

   Period : constant Ada.Real_Time.Time_Span :=
     Ada.Real_Time.Milliseconds (1000 / 60);

   Next_Release : Ada.Real_Time.Time;
begin

   Raylib.InitWindow (Width, Height, "Watermelon Chipmunk Example");

   SetIterations (Space, 10);
   SetGravity (Space, (0.0, -900.0));
   SetSleepTimeThreshold (Space, 0.5);

   for K in Object_Kind loop
      Images (K) := Raylib.LoadImage
        (Game_Resources.Resource_Path & Image_File (K));
      Textures (K) := Raylib.LoadTextureFromImage (Images (K));

      declare
         Test : constant access cpCollisionHandler :=
           AddCollisionHandler (Space, K'Enum_Rep, K'Enum_Rep);
      begin
         Test.postSolveFunc := PostSolveFunc'Unrestricted_Access;
      end;
   end loop;

   Setup_Game;

   Next_Release := Ada.Real_Time.Clock + Period;
   while not WindowShouldClose loop

      delay until Next_Release;
      Next_Release := Next_Release + Period;

      if not Gameover
        and then
          Drop_Timeout < Clock
        and then
          Boolean (IsMouseButtonPressed (MOUSE_BUTTON_LEFT))
      then
         Drop_Timeout := Clock + Drop_Interval;

         Add_Object (cpFloat (GetMousePosition.x),
                     Drop_Height,
                     Next_To_Drop);

         Next_To_Drop := Random_Object.Random (Obj_Gen);
      end if;

      if IsMouseButtonPressed (MOUSE_BUTTON_RIGHT) then
         Add_Object (cpFloat (GetMousePosition.x),
                     cpFloat (C_float (Height) - GetMousePosition.y),
                     Strawberry);
      end if;
      if IsMouseButtonPressed (MOUSE_BUTTON_MIDDLE) then
         Add_Object (cpFloat (GetMousePosition.x),
                     cpFloat (C_float (Height) - GetMousePosition.y),
                     Object_Kind'Last);
      end if;

      if not Gameover then
         Bodies_To_Merge.Clear;
         Step (Space, 1.0 / 60.0);

         for Elt of Bodies_To_Merge loop
            declare
               AB : constant cpBody := GetBody (Elt.A);
               BB : constant cpBody := GetBody (Elt.B);

               A_Pos : constant cpVect := GetPosition (AB);
               B_Pos : constant cpVect := GetPosition (BB);
            begin
               if ContainsBody (Space, AB) and then ContainsBody (Space, BB)
               then
                  RemoveShape (Space, Elt.A);
                  RemoveShape (Space, Elt.B);
                  RemoveBody (Space, AB);
                  RemoveBody (Space, BB);

                  Score := Score + Points (Elt.Kind);

                  if Elt.Kind /= Object_Kind'Last then
                     --  Merging the last object doesn't produce a new object
                     Add_Object ((A_Pos.X + B_Pos.X) / 2.0,
                                 (A_Pos.Y + B_Pos.Y) / 2.0,
                                 Object_Kind'Succ (Elt.Kind));
                  end if;
               end if;
            end;
         end loop;
      end if;

      BeginDrawing;
      ClearBackground (BLACK);
      --  Debug.Draw_Debug (Space);

      if not Gameover and then Drop_Timeout < Ada.Real_Time.Clock then
         Draw_Object (Next_To_Drop,
                      (cpFloat (GetMousePosition.x),
                       Drop_Height),
                      0.0);
      end if;

      DrawRectangle
        (int (C_float (Width) * 0.75) - 5,
         int (C_float (Height) * 0.2),
         10,
         int (C_float (Height) * 0.8),
         Raylib.WHITE);

      DrawRectangle
        (int (C_float (Width) * 0.25) - 5,
         int (C_float (Height) * 0.2),
         10,
         int (C_float (Height) * 0.8),
         Raylib.WHITE);

      DrawRectangle
        (int (C_float (Width) * 0.25),
         int (C_float (Height) * 1.0) - 10,
         int (C_float (Width) * 0.5),
         10,
         Raylib.WHITE);

      EachShape (Space, For_Each_Shape'Unrestricted_Access,
                 System.Null_Address);

      DrawText (text => "Score:" & Score'Img,
                posX => 0,
                posY => 40,
                fontSize => 20,
                color_p => Raylib.RED);

      if Gameover then
         declare
            Str : constant String := "GameOver!";
            Size : constant := 100;
            W : constant int := MeasureText (Str, Size);
         begin
            DrawText (text => Str,
                      posX => Width / 2 - W / 2,
                      posY => Height / 2,
                      fontSize => 100,
                      color_p => Raylib.RED);

            if Raylib.GUI.GuiButton ((C_float (Width) * 0.4,
                                     C_float (Height) * 0.7,
                                     C_float (Width) * 0.2,
                                     C_float (Height) * 0.1),
                                     "Restart") /= 0
              or else
                Boolean (Raylib.IsKeyPressed (Raylib.KEY_ENTER))
            then
               Setup_Game;
            end if;
         end;
      end if;

      --  Raylib.DrawFPS (0, 0);
      EndDrawing;
   end loop;

   CloseWindow;
end Watermelon;
