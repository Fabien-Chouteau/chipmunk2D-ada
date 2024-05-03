with System;
with Interfaces.C;
with Chipmunk; use Chipmunk;
with Chipmunk.Spaces;
with Raylib;

generic
   with function To_Raylib (Pos : Chipmunk.cpVect) return Raylib.Vector2;
   Shape_Outline_Color   : cpSpaceDebugColor := (1.0, 0.0, 0.0, 1.0);
   Constraint_Color      : cpSpaceDebugColor := (0.0, 1.0, 0.0, 1.0);
   Collision_Point_Color : cpSpaceDebugColor := (0.0, 0.0, 1.0, 1.0);
   Shape_Alpha           : Interfaces.C.C_float := 0.7;
package Chipmunk_Raylib_Debug is

   procedure Draw_Debug (Space : cpSpace);

private

   procedure Draw_Circle (pos : cpVect;
                          angle : cpFloat;
                          radius : cpFloat;
                          outlineColor : cpSpaceDebugColor;
                          fillColor : cpSpaceDebugColor;
                          data : cpDataPointer)
     with Convention => C;

   procedure Draw_Segment (a : cpVect;
                           b : cpVect;
                           color : cpSpaceDebugColor;
                           data : cpDataPointer)
     with Convention => C;

   procedure Draw_FatSegment (a : cpVect;
                              b : cpVect;
                              radius : cpFloat;
                              outlineColor : cpSpaceDebugColor;
                              fillColor : cpSpaceDebugColor;
                              data : cpDataPointer)
     with Convention => C;

   procedure Draw_Polygon (count : Interfaces.C.int;
                           verts : access C_cpVect_Array;
                           radius : cpFloat;
                           outlineColor : cpSpaceDebugColor;
                           fillColor : cpSpaceDebugColor;
                           data : cpDataPointer)
     with Convention => C;

   procedure Draw_Dot (size : cpFloat;
                       pos : cpVect;
                       color : cpSpaceDebugColor;
                       data : cpDataPointer)
     with Convention => C;

   function ColorForShape (shape : cpShape;
                           data : cpDataPointer)
                           return cpSpaceDebugColor
     with Convention => C;

   Debug_Draw : aliased Chipmunk.Spaces.cpSpaceDebugDrawOptions :=
     (drawCircle          => Draw_Circle'Unrestricted_Access,
      drawSegment         => Draw_Segment'Unrestricted_Access,
      drawFatSegment      => Draw_FatSegment'Unrestricted_Access,
      drawPolygon         => Draw_Polygon'Unrestricted_Access,
      drawDot             => Draw_Dot'Unrestricted_Access,
      flags               => DEBUG_DRAW_COLLISION_POINTS or
        DEBUG_DRAW_CONSTRAINTS or DEBUG_DRAW_SHAPES,
      shapeOutlineColor   => Shape_Outline_Color,
      colorForShape       => ColorForShape'Unrestricted_Access,
      constraintColor     => Constraint_Color,
      collisionPointColor => Collision_Point_Color,
      data => System.Null_Address);

end Chipmunk_Raylib_Debug;
