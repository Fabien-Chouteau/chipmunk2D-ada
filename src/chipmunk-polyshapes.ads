with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.PolyShapes
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpPolyShapeAlloc return cpPolyShape;
   --  
   pragma Import (C, cpPolyShapeAlloc, "cpPolyShapeAlloc");

   function cpPolyShapeInit (poly : cpPolyShape; body_p : cpBody; count : Interfaces.C.int; verts : access C_cpVect_Array; transform : cpTransform; radius : cpFloat) return cpPolyShape;
   --  
   pragma Import (C, cpPolyShapeInit, "cpPolyShapeInit");

   function cpPolyShapeInitRaw (poly : cpPolyShape; body_p : cpBody; count : Interfaces.C.int; verts : access C_cpVect_Array; radius : cpFloat) return cpPolyShape;
   --  
   pragma Import (C, cpPolyShapeInitRaw, "cpPolyShapeInitRaw");

   function cpPolyShapeNew (body_p : cpBody; count : Interfaces.C.int; verts : access C_cpVect_Array; transform : cpTransform; radius : cpFloat) return cpShape;
   --  
   pragma Import (C, cpPolyShapeNew, "cpPolyShapeNew");

   function cpPolyShapeNewRaw (body_p : cpBody; count : Interfaces.C.int; verts : access C_cpVect_Array; radius : cpFloat) return cpShape;
   --  
   pragma Import (C, cpPolyShapeNewRaw, "cpPolyShapeNewRaw");

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

   function cpPolyShapeGetCount (shape : cpShape) return Interfaces.C.int;
   --  
   pragma Import (C, cpPolyShapeGetCount, "cpPolyShapeGetCount");

   function cpPolyShapeGetVert (shape : cpShape; index : Interfaces.C.int) return cpVect;
   --  
   pragma Import (C, cpPolyShapeGetVert, "cpPolyShapeGetVert");

   function cpPolyShapeGetRadius (shape : cpShape) return cpFloat;
   --  
   pragma Import (C, cpPolyShapeGetRadius, "cpPolyShapeGetRadius");

end Chipmunk.PolyShapes;
