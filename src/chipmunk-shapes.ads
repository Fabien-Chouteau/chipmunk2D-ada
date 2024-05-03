with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Shapes
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   type cpPointQueryInfo is record
      shape : cpShape;
      point : cpVect;
      distance : cpFloat;
      gradient : cpVect;
   end record
      with Convention => C_Pass_By_Copy;

   type cpSegmentQueryInfo is record
      shape : cpShape;
      point : cpVect;
      normal : cpVect;
      alpha : cpFloat;
   end record
      with Convention => C_Pass_By_Copy;

   type cpShapeFilter is record
      group : cpGroup;
      categories : cpBitmask;
      mask : cpBitmask;
   end record
      with Convention => C_Pass_By_Copy;

   procedure cpShapeDestroy (shape : cpShape);
   --  
   pragma Import (C, cpShapeDestroy, "cpShapeDestroy");

   procedure cpShapeFree (shape : cpShape);
   --  
   pragma Import (C, cpShapeFree, "cpShapeFree");

   function cpShapeCacheBB (shape : cpShape) return cpBB;
   --  
   pragma Import (C, cpShapeCacheBB, "cpShapeCacheBB");

   function cpShapeUpdate (shape : cpShape; transform : cpTransform) return cpBB;
   --  
   pragma Import (C, cpShapeUpdate, "cpShapeUpdate");

   function cpShapePointQuery (shape : cpShape; p : cpVect; out_p : cpPointQueryInfo) return cpFloat;
   --  
   pragma Import (C, cpShapePointQuery, "cpShapePointQuery");

   function cpShapeSegmentQuery (shape : cpShape; a : cpVect; b : cpVect; radius : cpFloat; info : cpSegmentQueryInfo) return cpBool;
   --  
   pragma Import (C, cpShapeSegmentQuery, "cpShapeSegmentQuery");

   function cpShapesCollide (a : cpShape; b : cpShape) return cpContactPointSet;
   --  
   pragma Import (C, cpShapesCollide, "cpShapesCollide");

   function cpShapeGetSpace (shape : cpShape) return cpSpace;
   --  
   pragma Import (C, cpShapeGetSpace, "cpShapeGetSpace");

   function cpShapeGetBody (shape : cpShape) return cpBody;
   --  
   pragma Import (C, cpShapeGetBody, "cpShapeGetBody");

   procedure cpShapeSetBody (shape : cpShape; body_p : cpBody);
   --  
   pragma Import (C, cpShapeSetBody, "cpShapeSetBody");

   function cpShapeGetMass (shape : cpShape) return cpFloat;
   --  
   pragma Import (C, cpShapeGetMass, "cpShapeGetMass");

   procedure cpShapeSetMass (shape : cpShape; mass : cpFloat);
   --  
   pragma Import (C, cpShapeSetMass, "cpShapeSetMass");

   function cpShapeGetDensity (shape : cpShape) return cpFloat;
   --  
   pragma Import (C, cpShapeGetDensity, "cpShapeGetDensity");

   procedure cpShapeSetDensity (shape : cpShape; density : cpFloat);
   --  
   pragma Import (C, cpShapeSetDensity, "cpShapeSetDensity");

   function cpShapeGetMoment (shape : cpShape) return cpFloat;
   --  
   pragma Import (C, cpShapeGetMoment, "cpShapeGetMoment");

   function cpShapeGetArea (shape : cpShape) return cpFloat;
   --  
   pragma Import (C, cpShapeGetArea, "cpShapeGetArea");

   function cpShapeGetCenterOfGravity (shape : cpShape) return cpVect;
   --  
   pragma Import (C, cpShapeGetCenterOfGravity, "cpShapeGetCenterOfGravity");

   function cpShapeGetBB (shape : cpShape) return cpBB;
   --  
   pragma Import (C, cpShapeGetBB, "cpShapeGetBB");

   function cpShapeGetSensor (shape : cpShape) return cpBool;
   --  
   pragma Import (C, cpShapeGetSensor, "cpShapeGetSensor");

   procedure cpShapeSetSensor (shape : cpShape; sensor : cpBool);
   --  
   pragma Import (C, cpShapeSetSensor, "cpShapeSetSensor");

   function cpShapeGetElasticity (shape : cpShape) return cpFloat;
   --  
   pragma Import (C, cpShapeGetElasticity, "cpShapeGetElasticity");

   procedure cpShapeSetElasticity (shape : cpShape; elasticity : cpFloat);
   --  
   pragma Import (C, cpShapeSetElasticity, "cpShapeSetElasticity");

   function cpShapeGetFriction (shape : cpShape) return cpFloat;
   --  
   pragma Import (C, cpShapeGetFriction, "cpShapeGetFriction");

   procedure cpShapeSetFriction (shape : cpShape; friction : cpFloat);
   --  
   pragma Import (C, cpShapeSetFriction, "cpShapeSetFriction");

   function cpShapeGetSurfaceVelocity (shape : cpShape) return cpVect;
   --  
   pragma Import (C, cpShapeGetSurfaceVelocity, "cpShapeGetSurfaceVelocity");

   procedure cpShapeSetSurfaceVelocity (shape : cpShape; surfaceVelocity : cpVect);
   --  
   pragma Import (C, cpShapeSetSurfaceVelocity, "cpShapeSetSurfaceVelocity");

   function cpShapeGetUserData (shape : cpShape) return cpDataPointer;
   --  
   pragma Import (C, cpShapeGetUserData, "cpShapeGetUserData");

   procedure cpShapeSetUserData (shape : cpShape; userData : cpDataPointer);
   --  
   pragma Import (C, cpShapeSetUserData, "cpShapeSetUserData");

   function cpShapeGetCollisionType (shape : cpShape) return cpCollisionType;
   --  
   pragma Import (C, cpShapeGetCollisionType, "cpShapeGetCollisionType");

   procedure cpShapeSetCollisionType (shape : cpShape; collisionType : cpCollisionType);
   --  
   pragma Import (C, cpShapeSetCollisionType, "cpShapeSetCollisionType");

   function cpShapeGetFilter (shape : cpShape) return cpShapeFilter;
   --  
   pragma Import (C, cpShapeGetFilter, "cpShapeGetFilter");

   procedure cpShapeSetFilter (shape : cpShape; filter : cpShapeFilter);
   --  
   pragma Import (C, cpShapeSetFilter, "cpShapeSetFilter");

   function cpCircleShapeAlloc return cpCircleShape;
   --  
   pragma Import (C, cpCircleShapeAlloc, "cpCircleShapeAlloc");

   function cpCircleShapeInit (circle : cpCircleShape; body_p : cpBody; radius : cpFloat; offset : cpVect) return cpCircleShape;
   --  
   pragma Import (C, cpCircleShapeInit, "cpCircleShapeInit");

   function cpCircleShapeNew (body_p : cpBody; radius : cpFloat; offset : cpVect) return cpShape;
   --  
   pragma Import (C, cpCircleShapeNew, "cpCircleShapeNew");

   function cpCircleShapeGetOffset (shape : cpShape) return cpVect;
   --  
   pragma Import (C, cpCircleShapeGetOffset, "cpCircleShapeGetOffset");

   function cpCircleShapeGetRadius (shape : cpShape) return cpFloat;
   --  
   pragma Import (C, cpCircleShapeGetRadius, "cpCircleShapeGetRadius");

   function cpSegmentShapeAlloc return cpSegmentShape;
   --  
   pragma Import (C, cpSegmentShapeAlloc, "cpSegmentShapeAlloc");

   function cpSegmentShapeInit (seg : cpSegmentShape; body_p : cpBody; a : cpVect; b : cpVect; radius : cpFloat) return cpSegmentShape;
   --  
   pragma Import (C, cpSegmentShapeInit, "cpSegmentShapeInit");

   function cpSegmentShapeNew (body_p : cpBody; a : cpVect; b : cpVect; radius : cpFloat) return cpShape;
   --  
   pragma Import (C, cpSegmentShapeNew, "cpSegmentShapeNew");

   procedure cpSegmentShapeSetNeighbors (shape : cpShape; prev : cpVect; next : cpVect);
   --  
   pragma Import (C, cpSegmentShapeSetNeighbors, "cpSegmentShapeSetNeighbors");

   function cpSegmentShapeGetA (shape : cpShape) return cpVect;
   --  
   pragma Import (C, cpSegmentShapeGetA, "cpSegmentShapeGetA");

   function cpSegmentShapeGetB (shape : cpShape) return cpVect;
   --  
   pragma Import (C, cpSegmentShapeGetB, "cpSegmentShapeGetB");

   function cpSegmentShapeGetNormal (shape : cpShape) return cpVect;
   --  
   pragma Import (C, cpSegmentShapeGetNormal, "cpSegmentShapeGetNormal");

   function cpSegmentShapeGetRadius (shape : cpShape) return cpFloat;
   --  
   pragma Import (C, cpSegmentShapeGetRadius, "cpSegmentShapeGetRadius");

end Chipmunk.Shapes;
