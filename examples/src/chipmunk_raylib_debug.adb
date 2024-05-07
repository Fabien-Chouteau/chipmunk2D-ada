with Ada.Numerics.Generic_Elementary_Functions;
with Raylib; use Raylib;
with Interfaces.C; use Interfaces.C;

with Ada.Unchecked_Conversion;
with Chipmunk.Shapes;
with Chipmunk.Bodies;

package body Chipmunk_Raylib_Debug is

   package C_float_Funcs
   is new Ada.Numerics.Generic_Elementary_Functions (cpFloat);
   use C_float_Funcs;

   pragma Suppress_All;

   ----------------
   -- Draw_Debug --
   ----------------

   procedure Draw_Debug (Space : cpSpace) is
   begin
      Chipmunk.Spaces.DebugDraw (Space, Debug_Draw'Access);
   end Draw_Debug;

   function To_Raylib_color (C : cpSpaceDebugColor) return Color
   is ((unsigned_char (255.0 * C.R),
       unsigned_char (255.0 * C.G),
       unsigned_char (255.0 * C.B),
       unsigned_char (255.0 * C.A)));

   -----------------
   -- Draw_Circle --
   -----------------

   procedure Draw_Circle (pos : cpVect;
                          angle : cpFloat;
                          radius : cpFloat;
                          outlineColor : cpSpaceDebugColor;
                          fillColor : cpSpaceDebugColor;
                          data : cpDataPointer)
   is
      pragma Unreferenced (data);

      Rpos : constant Vector2 := To_Raylib (pos);
      SX : constant int := int (Rpos.x);
      SY : constant int := int (Rpos.y);

      Rad : constant C_float := C_float (radius);

      EX : constant int := int (cpFloat (Rpos.x) + Cos (-angle) * radius);
      EY : constant int := int (cpFloat (Rpos.y) + Sin (-angle) * radius);
   begin
      DrawCircle (SX, SY, Rad, To_Raylib_color (fillColor));
      DrawCircleLines (SX, SY, Rad, To_Raylib_color (outlineColor));
      DrawLine (SX, SY, EX, EY, To_Raylib_color (outlineColor));
   end Draw_Circle;

   ------------------
   -- Draw_Segment --
   ------------------

   procedure Draw_Segment (a : cpVect;
                           b : cpVect;
                           color : cpSpaceDebugColor;
                           data : cpDataPointer)
   is
      pragma Unreferenced (data);
      RA : constant Vector2 := To_Raylib (a);
      RB : constant Vector2 := To_Raylib (b);

      SX : constant int := int (RA.x);
      EX : constant int := int (RB.x);
      SY : constant int := int (RA.y);
      EY : constant int := int (RB.y);
   begin
      DrawLine (SX, SY, EX, EY, To_Raylib_color (color));
   end Draw_Segment;

   ---------------------
   -- Draw_FatSegment --
   ---------------------

   procedure Draw_FatSegment (a : cpVect;
                              b : cpVect;
                              radius : cpFloat;
                              outlineColor : cpSpaceDebugColor;
                              fillColor : cpSpaceDebugColor;
                              data : cpDataPointer)
   is
      pragma Unreferenced (data, outlineColor);
      RA : constant Vector2 := To_Raylib (a);
      RB : constant Vector2 := To_Raylib (b);

      SX : constant C_float := RA.x;
      EX : constant C_float := RB.x;
      SY : constant C_float := RA.y;
      EY : constant C_float := RB.y;
   begin
      DrawLineEx ((SX, SY), (EX, EY), C_float (radius) * 2.0,
                  To_Raylib_color (fillColor));
   end Draw_FatSegment;

   ------------------
   -- Draw_Polygon --
   ------------------

   procedure Draw_Polygon (count : Interfaces.C.int;
                           verts : access C_cpVect_Array;
                           radius : cpFloat;
                           outlineColor : cpSpaceDebugColor;
                           fillColor : cpSpaceDebugColor;
                           data : cpDataPointer)
   is
      First : constant cpVect := (if count > 0
                                  then verts (verts'First)
                                  else (0.0, 0.0));
   begin
      for X in 1 .. unsigned (count) loop
         declare
            A : cpVect renames verts (verts'First + X - 1);
            B : cpVect renames verts (verts'First + X);

            BF : constant cpVect :=
              (if X = unsigned (count)
               then First
               else B);
         begin
            Draw_FatSegment (A, BF, radius, outlineColor, fillColor, data);
         end;
      end loop;
   end Draw_Polygon;

   --------------
   -- Draw_Dot --
   --------------

   procedure Draw_Dot (size : cpFloat;
                       pos : cpVect;
                       color : cpSpaceDebugColor;
                       data : cpDataPointer)
   is
      pragma Unreferenced (data);
      Rpos : constant Vector2 := To_Raylib (pos);
      X : constant int := int (Rpos.x);
      Y : constant int := int (Rpos.y);
   begin
      DrawCircle (X, Y, C_float (size / 2.0), To_Raylib_color (color));
   end Draw_Dot;

   -------------------
   -- ColorForShape --
   -------------------

   function ColorForShape (shape : cpShape;
                           data : cpDataPointer)
                           return cpSpaceDebugColor
   is
      type Pointer is mod 2**Standard'Address_Size
        with Size => Standard'Address_Size;

      function Shift_Left
        (Value  : Pointer;
         Amount : Natural) return Pointer
        with Import, Convention => Intrinsic;

      function Shift_Right
        (Value  : Pointer;
         Amount : Natural) return Pointer
        with Import, Convention => Intrinsic;

      function To_Unsigned
      is new Ada.Unchecked_Conversion (cpShape, Pointer);

      pragma Unreferenced (data);

      Bod : cpBody;
      Ptr : Pointer := To_Unsigned (shape);
   begin
      if Chipmunk.Shapes.GetSensor (shape) then
         return (1.0, 1.0, 1.0, 0.1);
      else
         Bod := Chipmunk.Shapes.GetBody (shape);
         if Chipmunk.Bodies.IsSleeping (Bod) then
            return (88.0 / 255.0,
                    110.0 / 255.0,
                    117.0 / 255.0,
                    1.0);
         else
            --  Shaking things up!
            Ptr := (Ptr + 16#7ed55d16#) + Shift_Left (Ptr, 12);
            Ptr := (Ptr xor 16#c761c23c#) xor Shift_Right (Ptr, 19);
            Ptr := (Ptr + 16#165667b1#) + Shift_Left (Ptr, 5);
            Ptr := (Ptr + 16#d3a2646c#) xor Shift_Left (Ptr, 9);
            Ptr := (Ptr + 16#fd7046c5#) + Shift_Left (Ptr, 3);
            Ptr := (Ptr xor 16#b55a4f09#) xor Shift_Right (Ptr, 16);

            return (C_float (Shift_Right (Ptr, 0) and 16#FF#) / 255.0,
                    C_float (Shift_Right (Ptr, 8) and 16#FF#) / 255.0,
                    C_float (Shift_Right (Ptr, 16) and 16#FF#) / 255.0,
                    Shape_Alpha);
         end if;
      end if;
   end ColorForShape;

end Chipmunk_Raylib_Debug;
