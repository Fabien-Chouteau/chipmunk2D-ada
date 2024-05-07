with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.PolyShapes
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function Alloc return cpPolyShape;
   --  
   pragma Import (C, Alloc, "cpPolyShapeAlloc");

   function Init (poly : cpPolyShape; body_p : cpBody; count : Interfaces.C.int; verts : access C_cpVect_Array; transform : cpTransform; radius : cpFloat) return cpPolyShape;
   --  
   pragma Import (C, Init, "cpPolyShapeInit");

   function InitRaw (poly : cpPolyShape; body_p : cpBody; count : Interfaces.C.int; verts : access C_cpVect_Array; radius : cpFloat) return cpPolyShape;
   --  
   pragma Import (C, InitRaw, "cpPolyShapeInitRaw");

   function NewPolyShape (body_p : cpBody; count : Interfaces.C.int; verts : access C_cpVect_Array; transform : cpTransform; radius : cpFloat) return cpShape;
   --  
   pragma Import (C, NewPolyShape, "cpPolyShapeNew");

   function NewRaw (body_p : cpBody; count : Interfaces.C.int; verts : access C_cpVect_Array; radius : cpFloat) return cpShape;
   --  
   pragma Import (C, NewRaw, "cpPolyShapeNewRaw");

   function cpBoxShapeInit (poly : cpPolyShape; body_p : cpBody; width : cpFloat; height : cpFloat; radius : cpFloat) return cpPolyShape;
   --  
   pragma Import (C, cpBoxShapeInit, "cpBoxShapeInit");

   function cpBoxShapeInit2 (poly : cpPolyShape; body_p : cpBody; box : cpBB; radius : cpFloat) return cpPolyShape;
   --  
   pragma Import (C, cpBoxShapeInit2, "cpBoxShapeInit2");

   function cpBoxShapeNew (body_p : cpBody; width : cpFloat; height : cpFloat; radius : cpFloat) return cpShape;
   --  
   pragma Import (C, cpBoxShapeNew, "cpBoxShapeNew");

   function cpBoxShapeNew2 (body_p : cpBody; box : cpBB; radius : cpFloat) return cpShape;
   --  
   pragma Import (C, cpBoxShapeNew2, "cpBoxShapeNew2");

   function GetCount (shape : cpShape) return Interfaces.C.int;
   --  
   pragma Import (C, GetCount, "cpPolyShapeGetCount");

   function GetVert (shape : cpShape; index : Interfaces.C.int) return cpVect;
   --  
   pragma Import (C, GetVert, "cpPolyShapeGetVert");

   function GetRadius (shape : cpShape) return cpFloat;
   --  
   pragma Import (C, GetRadius, "cpPolyShapeGetRadius");

end Chipmunk.PolyShapes;
