with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Spaces
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   type cpCollisionBeginFunc is access    function  (arb : cpArbiter; space : cpSpace; userData : cpDataPointer) return cpBool

     with Convention => C;

   type cpCollisionPreSolveFunc is access    function  (arb : cpArbiter; space : cpSpace; userData : cpDataPointer) return cpBool

     with Convention => C;

   type cpCollisionPostSolveFunc is access    procedure  (arb : cpArbiter; space : cpSpace; userData : cpDataPointer)

     with Convention => C;

   type cpCollisionSeparateFunc is access    procedure  (arb : cpArbiter; space : cpSpace; userData : cpDataPointer)

     with Convention => C;

   type cpPostStepFunc is access    procedure  (space : cpSpace; key : System.Address; data : System.Address)

     with Convention => C;

   type cpSpacePointQueryFunc is access    procedure  (shape : cpShape; point : cpVect; distance : cpFloat; gradient : cpVect; data : System.Address)

     with Convention => C;

   type cpSpaceSegmentQueryFunc is access    procedure  (shape : cpShape; point : cpVect; normal : cpVect; alpha : cpFloat; data : System.Address)

     with Convention => C;

   type cpSpaceBBQueryFunc is access    procedure  (shape : cpShape; data : System.Address)

     with Convention => C;

   type cpSpaceShapeQueryFunc is access    procedure  (shape : cpShape; points : access cpContactPointSet; data : System.Address)

     with Convention => C;

   type cpSpaceBodyIteratorFunc is access    procedure  (body_p : cpBody; data : System.Address)

     with Convention => C;

   type cpSpaceShapeIteratorFunc is access    procedure  (shape : cpShape; data : System.Address)

     with Convention => C;

   type cpSpaceConstraintIteratorFunc is access    procedure  (constraint : cpConstraint; data : System.Address)

     with Convention => C;

   type cpSpaceDebugDrawCircleImpl is access    procedure  (pos : cpVect; angle : cpFloat; radius : cpFloat; outlineColor : cpSpaceDebugColor; fillColor : cpSpaceDebugColor; data : cpDataPointer)

     with Convention => C;

   type cpSpaceDebugDrawSegmentImpl is access    procedure  (a : cpVect; b : cpVect; color : cpSpaceDebugColor; data : cpDataPointer)

     with Convention => C;

   type cpSpaceDebugDrawFatSegmentImpl is access    procedure  (a : cpVect; b : cpVect; radius : cpFloat; outlineColor : cpSpaceDebugColor; fillColor : cpSpaceDebugColor; data : cpDataPointer)

     with Convention => C;

   type cpSpaceDebugDrawPolygonImpl is access    procedure  (count : Interfaces.C.int; verts : access C_cpVect_Array; radius : cpFloat; outlineColor : cpSpaceDebugColor; fillColor : cpSpaceDebugColor; data : cpDataPointer)

     with Convention => C;

   type cpSpaceDebugDrawDotImpl is access    procedure  (size : cpFloat; pos : cpVect; color : cpSpaceDebugColor; data : cpDataPointer)

     with Convention => C;

   type cpSpaceDebugDrawColorForShapeImpl is access    function  (shape : cpShape; data : cpDataPointer) return cpSpaceDebugColor

     with Convention => C;

   type cpSpaceDebugDrawOptions is record
      drawCircle : cpSpaceDebugDrawCircleImpl;
      drawSegment : cpSpaceDebugDrawSegmentImpl;
      drawFatSegment : cpSpaceDebugDrawFatSegmentImpl;
      drawPolygon : cpSpaceDebugDrawPolygonImpl;
      drawDot : cpSpaceDebugDrawDotImpl;
      flags : cpSpaceDebugDrawFlags;
      shapeOutlineColor : cpSpaceDebugColor;
      colorForShape : cpSpaceDebugDrawColorForShapeImpl;
      constraintColor : cpSpaceDebugColor;
      collisionPointColor : cpSpaceDebugColor;
      data : cpDataPointer;
   end record
      with Convention => C_Pass_By_Copy;

   function cpSpaceAlloc return cpSpace;
   --  
   pragma Import (C, cpSpaceAlloc, "cpSpaceAlloc");

   function cpSpaceInit (space : cpSpace) return cpSpace;
   --  
   pragma Import (C, cpSpaceInit, "cpSpaceInit");

   function cpSpaceNew return cpSpace;
   --  
   pragma Import (C, cpSpaceNew, "cpSpaceNew");

   procedure cpSpaceDestroy (space : cpSpace);
   --  
   pragma Import (C, cpSpaceDestroy, "cpSpaceDestroy");

   procedure cpSpaceFree (space : cpSpace);
   --  
   pragma Import (C, cpSpaceFree, "cpSpaceFree");

   function cpSpaceGetIterations (space : cpSpace) return Interfaces.C.int;
   --  
   pragma Import (C, cpSpaceGetIterations, "cpSpaceGetIterations");

   procedure cpSpaceSetIterations (space : cpSpace; iterations : Interfaces.C.int);
   --  
   pragma Import (C, cpSpaceSetIterations, "cpSpaceSetIterations");

   function cpSpaceGetGravity (space : cpSpace) return cpVect;
   --  
   pragma Import (C, cpSpaceGetGravity, "cpSpaceGetGravity");

   procedure cpSpaceSetGravity (space : cpSpace; gravity : cpVect);
   --  
   pragma Import (C, cpSpaceSetGravity, "cpSpaceSetGravity");

   function cpSpaceGetDamping (space : cpSpace) return cpFloat;
   --  
   pragma Import (C, cpSpaceGetDamping, "cpSpaceGetDamping");

   procedure cpSpaceSetDamping (space : cpSpace; damping : cpFloat);
   --  
   pragma Import (C, cpSpaceSetDamping, "cpSpaceSetDamping");

   function cpSpaceGetIdleSpeedThreshold (space : cpSpace) return cpFloat;
   --  
   pragma Import (C, cpSpaceGetIdleSpeedThreshold, "cpSpaceGetIdleSpeedThreshold");

   procedure cpSpaceSetIdleSpeedThreshold (space : cpSpace; idleSpeedThreshold : cpFloat);
   --  
   pragma Import (C, cpSpaceSetIdleSpeedThreshold, "cpSpaceSetIdleSpeedThreshold");

   function cpSpaceGetSleepTimeThreshold (space : cpSpace) return cpFloat;
   --  
   pragma Import (C, cpSpaceGetSleepTimeThreshold, "cpSpaceGetSleepTimeThreshold");

   procedure cpSpaceSetSleepTimeThreshold (space : cpSpace; sleepTimeThreshold : cpFloat);
   --  
   pragma Import (C, cpSpaceSetSleepTimeThreshold, "cpSpaceSetSleepTimeThreshold");

   function cpSpaceGetCollisionSlop (space : cpSpace) return cpFloat;
   --  
   pragma Import (C, cpSpaceGetCollisionSlop, "cpSpaceGetCollisionSlop");

   procedure cpSpaceSetCollisionSlop (space : cpSpace; collisionSlop : cpFloat);
   --  
   pragma Import (C, cpSpaceSetCollisionSlop, "cpSpaceSetCollisionSlop");

   function cpSpaceGetCollisionBias (space : cpSpace) return cpFloat;
   --  
   pragma Import (C, cpSpaceGetCollisionBias, "cpSpaceGetCollisionBias");

   procedure cpSpaceSetCollisionBias (space : cpSpace; collisionBias : cpFloat);
   --  
   pragma Import (C, cpSpaceSetCollisionBias, "cpSpaceSetCollisionBias");

   function cpSpaceGetCollisionPersistence (space : cpSpace) return cpTimestamp;
   --  
   pragma Import (C, cpSpaceGetCollisionPersistence, "cpSpaceGetCollisionPersistence");

   procedure cpSpaceSetCollisionPersistence (space : cpSpace; collisionPersistence : cpTimestamp);
   --  
   pragma Import (C, cpSpaceSetCollisionPersistence, "cpSpaceSetCollisionPersistence");

   function cpSpaceGetUserData (space : cpSpace) return cpDataPointer;
   --  
   pragma Import (C, cpSpaceGetUserData, "cpSpaceGetUserData");

   procedure cpSpaceSetUserData (space : cpSpace; userData : cpDataPointer);
   --  
   pragma Import (C, cpSpaceSetUserData, "cpSpaceSetUserData");

   function cpSpaceGetStaticBody (space : cpSpace) return cpBody;
   --  
   pragma Import (C, cpSpaceGetStaticBody, "cpSpaceGetStaticBody");

   function cpSpaceGetCurrentTimeStep (space : cpSpace) return cpFloat;
   --  
   pragma Import (C, cpSpaceGetCurrentTimeStep, "cpSpaceGetCurrentTimeStep");

   function cpSpaceIsLocked (space : cpSpace) return cpBool;
   --  
   pragma Import (C, cpSpaceIsLocked, "cpSpaceIsLocked");

   function cpSpaceAddDefaultCollisionHandler (space : cpSpace) return access cpCollisionHandler;
   --  
   pragma Import (C, cpSpaceAddDefaultCollisionHandler, "cpSpaceAddDefaultCollisionHandler");

   function cpSpaceAddCollisionHandler (space : cpSpace; a : cpCollisionType; b : cpCollisionType) return access cpCollisionHandler;
   --  
   pragma Import (C, cpSpaceAddCollisionHandler, "cpSpaceAddCollisionHandler");

   function cpSpaceAddWildcardHandler (space : cpSpace; type_p : cpCollisionType) return access cpCollisionHandler;
   --  
   pragma Import (C, cpSpaceAddWildcardHandler, "cpSpaceAddWildcardHandler");

   function cpSpaceAddShape (space : cpSpace; shape : cpShape) return cpShape;
   --  
   pragma Import (C, cpSpaceAddShape, "cpSpaceAddShape");

   function cpSpaceAddBody (space : cpSpace; body_p : cpBody) return cpBody;
   --  
   pragma Import (C, cpSpaceAddBody, "cpSpaceAddBody");

   function cpSpaceAddConstraint (space : cpSpace; constraint : cpConstraint) return cpConstraint;
   --  
   pragma Import (C, cpSpaceAddConstraint, "cpSpaceAddConstraint");

   procedure cpSpaceRemoveShape (space : cpSpace; shape : cpShape);
   --  
   pragma Import (C, cpSpaceRemoveShape, "cpSpaceRemoveShape");

   procedure cpSpaceRemoveBody (space : cpSpace; body_p : cpBody);
   --  
   pragma Import (C, cpSpaceRemoveBody, "cpSpaceRemoveBody");

   procedure cpSpaceRemoveConstraint (space : cpSpace; constraint : cpConstraint);
   --  
   pragma Import (C, cpSpaceRemoveConstraint, "cpSpaceRemoveConstraint");

   function cpSpaceContainsShape (space : cpSpace; shape : cpShape) return cpBool;
   --  
   pragma Import (C, cpSpaceContainsShape, "cpSpaceContainsShape");

   function cpSpaceContainsBody (space : cpSpace; body_p : cpBody) return cpBool;
   --  
   pragma Import (C, cpSpaceContainsBody, "cpSpaceContainsBody");

   function cpSpaceContainsConstraint (space : cpSpace; constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpSpaceContainsConstraint, "cpSpaceContainsConstraint");

   function cpSpaceAddPostStepCallback (space : cpSpace; func : cpPostStepFunc; key : System.Address; data : System.Address) return cpBool;
   --  
   pragma Import (C, cpSpaceAddPostStepCallback, "cpSpaceAddPostStepCallback");

   procedure cpSpacePointQuery (space : cpSpace; point : cpVect; maxDistance : cpFloat; filter : cpShapeFilter; func : cpSpacePointQueryFunc; data : System.Address);
   --  
   pragma Import (C, cpSpacePointQuery, "cpSpacePointQuery");

   function cpSpacePointQueryNearest (space : cpSpace; point : cpVect; maxDistance : cpFloat; filter : cpShapeFilter; out_p : cpPointQueryInfo) return cpShape;
   --  
   pragma Import (C, cpSpacePointQueryNearest, "cpSpacePointQueryNearest");

   procedure cpSpaceSegmentQuery (space : cpSpace; start : cpVect; end_p : cpVect; radius : cpFloat; filter : cpShapeFilter; func : cpSpaceSegmentQueryFunc; data : System.Address);
   --  
   pragma Import (C, cpSpaceSegmentQuery, "cpSpaceSegmentQuery");

   function cpSpaceSegmentQueryFirst (space : cpSpace; start : cpVect; end_p : cpVect; radius : cpFloat; filter : cpShapeFilter; out_p : cpSegmentQueryInfo) return cpShape;
   --  
   pragma Import (C, cpSpaceSegmentQueryFirst, "cpSpaceSegmentQueryFirst");

   procedure cpSpaceBBQuery (space : cpSpace; bb : cpBB; filter : cpShapeFilter; func : cpSpaceBBQueryFunc; data : System.Address);
   --  
   pragma Import (C, cpSpaceBBQuery, "cpSpaceBBQuery");

   function cpSpaceShapeQuery (space : cpSpace; shape : cpShape; func : cpSpaceShapeQueryFunc; data : System.Address) return cpBool;
   --  
   pragma Import (C, cpSpaceShapeQuery, "cpSpaceShapeQuery");

   procedure cpSpaceEachBody (space : cpSpace; func : cpSpaceBodyIteratorFunc; data : System.Address);
   --  
   pragma Import (C, cpSpaceEachBody, "cpSpaceEachBody");

   procedure cpSpaceEachShape (space : cpSpace; func : cpSpaceShapeIteratorFunc; data : System.Address);
   --  
   pragma Import (C, cpSpaceEachShape, "cpSpaceEachShape");

   procedure cpSpaceEachConstraint (space : cpSpace; func : cpSpaceConstraintIteratorFunc; data : System.Address);
   --  
   pragma Import (C, cpSpaceEachConstraint, "cpSpaceEachConstraint");

   procedure cpSpaceReindexStatic (space : cpSpace);
   --  
   pragma Import (C, cpSpaceReindexStatic, "cpSpaceReindexStatic");

   procedure cpSpaceReindexShape (space : cpSpace; shape : cpShape);
   --  
   pragma Import (C, cpSpaceReindexShape, "cpSpaceReindexShape");

   procedure cpSpaceReindexShapesForBody (space : cpSpace; body_p : cpBody);
   --  
   pragma Import (C, cpSpaceReindexShapesForBody, "cpSpaceReindexShapesForBody");

   procedure cpSpaceUseSpatialHash (space : cpSpace; dim : cpFloat; count : Interfaces.C.int);
   --  
   pragma Import (C, cpSpaceUseSpatialHash, "cpSpaceUseSpatialHash");

   procedure cpSpaceStep (space : cpSpace; dt : cpFloat);
   --  
   pragma Import (C, cpSpaceStep, "cpSpaceStep");

   procedure cpSpaceDebugDraw (space : cpSpace; options : access cpSpaceDebugDrawOptions);
   --  
   pragma Import (C, cpSpaceDebugDraw, "cpSpaceDebugDraw");

end Chipmunk.Spaces;
