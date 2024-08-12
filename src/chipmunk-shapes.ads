package Chipmunk.Shapes
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   type cpPointQueryInfo is record
      shape    : cpShape;
      point    : cpVect;
      distance : cpFloat;
      gradient : cpVect;
   end record
   with Convention => C_Pass_By_Copy;

   type cpSegmentQueryInfo is record
      shape  : cpShape;
      point  : cpVect;
      normal : cpVect;
      alpha  : cpFloat;
   end record
   with Convention => C_Pass_By_Copy;

   type cpShapeFilter is record
      group      : cpGroup;
      categories : cpBitmask;
      mask       : cpBitmask;
   end record
   with Convention => C_Pass_By_Copy;

   procedure Destroy (shape : cpShape);
   --
   pragma Import (C, Destroy, "cpShapeDestroy");

   procedure Free (shape : cpShape);
   --
   pragma Import (C, Free, "cpShapeFree");

   function CacheBB (shape : cpShape) return cpBB;
   --
   pragma Import (C, CacheBB, "cpShapeCacheBB");

   function Update (shape : cpShape; transform : cpTransform) return cpBB;
   --
   pragma Import (C, Update, "cpShapeUpdate");

   function PointQuery
     (shape : cpShape; p : cpVect; out_p : cpPointQueryInfo) return cpFloat;
   --
   pragma Import (C, PointQuery, "cpShapePointQuery");

   function SegmentQuery
     (shape  : cpShape;
      a      : cpVect;
      b      : cpVect;
      radius : cpFloat;
      info   : cpSegmentQueryInfo) return cpBool;
   --
   pragma Import (C, SegmentQuery, "cpShapeSegmentQuery");

   function sCollide (a : cpShape; b : cpShape) return cpContactPointSet;
   --
   pragma Import (C, sCollide, "cpShapesCollide");

   function GetSpace (shape : cpShape) return cpSpace;
   --
   pragma Import (C, GetSpace, "cpShapeGetSpace");

   function GetBody (shape : cpShape) return cpBody;
   --
   pragma Import (C, GetBody, "cpShapeGetBody");

   procedure SetBody (shape : cpShape; body_p : cpBody);
   --
   pragma Import (C, SetBody, "cpShapeSetBody");

   function GetMass (shape : cpShape) return cpFloat;
   --
   pragma Import (C, GetMass, "cpShapeGetMass");

   procedure SetMass (shape : cpShape; mass : cpFloat);
   --
   pragma Import (C, SetMass, "cpShapeSetMass");

   function GetDensity (shape : cpShape) return cpFloat;
   --
   pragma Import (C, GetDensity, "cpShapeGetDensity");

   procedure SetDensity (shape : cpShape; density : cpFloat);
   --
   pragma Import (C, SetDensity, "cpShapeSetDensity");

   function GetMoment (shape : cpShape) return cpFloat;
   --
   pragma Import (C, GetMoment, "cpShapeGetMoment");

   function GetArea (shape : cpShape) return cpFloat;
   --
   pragma Import (C, GetArea, "cpShapeGetArea");

   function GetCenterOfGravity (shape : cpShape) return cpVect;
   --
   pragma Import (C, GetCenterOfGravity, "cpShapeGetCenterOfGravity");

   function GetBB (shape : cpShape) return cpBB;
   --
   pragma Import (C, GetBB, "cpShapeGetBB");

   function GetSensor (shape : cpShape) return cpBool;
   --
   pragma Import (C, GetSensor, "cpShapeGetSensor");

   procedure SetSensor (shape : cpShape; sensor : cpBool);
   --
   pragma Import (C, SetSensor, "cpShapeSetSensor");

   function GetElasticity (shape : cpShape) return cpFloat;
   --
   pragma Import (C, GetElasticity, "cpShapeGetElasticity");

   procedure SetElasticity (shape : cpShape; elasticity : cpFloat);
   --
   pragma Import (C, SetElasticity, "cpShapeSetElasticity");

   function GetFriction (shape : cpShape) return cpFloat;
   --
   pragma Import (C, GetFriction, "cpShapeGetFriction");

   procedure SetFriction (shape : cpShape; friction : cpFloat);
   --
   pragma Import (C, SetFriction, "cpShapeSetFriction");

   function GetSurfaceVelocity (shape : cpShape) return cpVect;
   --
   pragma Import (C, GetSurfaceVelocity, "cpShapeGetSurfaceVelocity");

   procedure SetSurfaceVelocity (shape : cpShape; surfaceVelocity : cpVect);
   --
   pragma Import (C, SetSurfaceVelocity, "cpShapeSetSurfaceVelocity");

   function GetUserData (shape : cpShape) return cpDataPointer;
   --
   pragma Import (C, GetUserData, "cpShapeGetUserData");

   procedure SetUserData (shape : cpShape; userData : cpDataPointer);
   --
   pragma Import (C, SetUserData, "cpShapeSetUserData");

   function GetCollisionType (shape : cpShape) return cpCollisionType;
   --
   pragma Import (C, GetCollisionType, "cpShapeGetCollisionType");

   procedure SetCollisionType
     (shape : cpShape; collisionType : cpCollisionType);
   --
   pragma Import (C, SetCollisionType, "cpShapeSetCollisionType");

   function GetFilter (shape : cpShape) return cpShapeFilter;
   --
   pragma Import (C, GetFilter, "cpShapeGetFilter");

   procedure SetFilter (shape : cpShape; filter : cpShapeFilter);
   --
   pragma Import (C, SetFilter, "cpShapeSetFilter");

   function cpCircleShapeAlloc return cpCircleShape;
   --
   pragma Import (C, cpCircleShapeAlloc, "cpCircleShapeAlloc");

   function cpCircleShapeInit
     (circle : cpCircleShape;
      body_p : cpBody;
      radius : cpFloat;
      offset : cpVect) return cpCircleShape;
   --
   pragma Import (C, cpCircleShapeInit, "cpCircleShapeInit");

   function cpCircleShapeNew
     (body_p : cpBody; radius : cpFloat; offset : cpVect) return cpShape;
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

   function cpSegmentShapeInit
     (seg    : cpSegmentShape;
      body_p : cpBody;
      a      : cpVect;
      b      : cpVect;
      radius : cpFloat) return cpSegmentShape;
   --
   pragma Import (C, cpSegmentShapeInit, "cpSegmentShapeInit");

   function cpSegmentShapeNew
     (body_p : cpBody; a : cpVect; b : cpVect; radius : cpFloat)
      return cpShape;
   --
   pragma Import (C, cpSegmentShapeNew, "cpSegmentShapeNew");

   procedure cpSegmentShapeSetNeighbors
     (shape : cpShape; prev : cpVect; next : cpVect);
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
