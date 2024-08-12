package Chipmunk.Spaces
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   type cpCollisionBeginFunc is
     access function
       (arb : cpArbiter; space : cpSpace; userData : cpDataPointer)
        return cpBool

   with Convention => C;

   type cpCollisionPreSolveFunc is
     access function
       (arb : cpArbiter; space : cpSpace; userData : cpDataPointer)
        return cpBool

   with Convention => C;

   type cpCollisionPostSolveFunc is
     access procedure
       (arb : cpArbiter; space : cpSpace; userData : cpDataPointer)

   with Convention => C;

   type cpCollisionSeparateFunc is
     access procedure
       (arb : cpArbiter; space : cpSpace; userData : cpDataPointer)

   with Convention => C;

   type cpPostStepFunc is
     access procedure
       (space : cpSpace; key : System.Address; data : System.Address)

   with Convention => C;

   type cpSpacePointQueryFunc is
     access procedure
       (shape    : cpShape;
        point    : cpVect;
        distance : cpFloat;
        gradient : cpVect;
        data     : System.Address)

   with Convention => C;

   type cpSpaceSegmentQueryFunc is
     access procedure
       (shape  : cpShape;
        point  : cpVect;
        normal : cpVect;
        alpha  : cpFloat;
        data   : System.Address)

   with Convention => C;

   type cpSpaceBBQueryFunc is
     access procedure  (shape : cpShape; data : System.Address)

   with Convention => C;

   type cpSpaceShapeQueryFunc is
     access procedure
       (shape  : cpShape;
        points : access cpContactPointSet;
        data   : System.Address)

   with Convention => C;

   type cpSpaceBodyIteratorFunc is
     access procedure  (body_p : cpBody; data : System.Address)

   with Convention => C;

   type cpSpaceShapeIteratorFunc is
     access procedure  (shape : cpShape; data : System.Address)

   with Convention => C;

   type cpSpaceConstraintIteratorFunc is
     access procedure  (constraint : cpConstraint; data : System.Address)

   with Convention => C;

   type cpSpaceDebugDrawCircleImpl is
     access procedure
       (pos          : cpVect;
        angle        : cpFloat;
        radius       : cpFloat;
        outlineColor : cpSpaceDebugColor;
        fillColor    : cpSpaceDebugColor;
        data         : cpDataPointer)

   with Convention => C;

   type cpSpaceDebugDrawSegmentImpl is
     access procedure
       (a     : cpVect;
        b     : cpVect;
        color : cpSpaceDebugColor;
        data  : cpDataPointer)

   with Convention => C;

   type cpSpaceDebugDrawFatSegmentImpl is
     access procedure
       (a            : cpVect;
        b            : cpVect;
        radius       : cpFloat;
        outlineColor : cpSpaceDebugColor;
        fillColor    : cpSpaceDebugColor;
        data         : cpDataPointer)

   with Convention => C;

   type cpSpaceDebugDrawPolygonImpl is
     access procedure
       (count        : Interfaces.C.int;
        verts        : access C_cpVect_Array;
        radius       : cpFloat;
        outlineColor : cpSpaceDebugColor;
        fillColor    : cpSpaceDebugColor;
        data         : cpDataPointer)

   with Convention => C;

   type cpSpaceDebugDrawDotImpl is
     access procedure
       (size  : cpFloat;
        pos   : cpVect;
        color : cpSpaceDebugColor;
        data  : cpDataPointer)

   with Convention => C;

   type cpSpaceDebugDrawColorForShapeImpl is
     access function
       (shape : cpShape; data : cpDataPointer) return cpSpaceDebugColor

   with Convention => C;

   type cpSpaceDebugDrawOptions is record
      drawCircle          : cpSpaceDebugDrawCircleImpl;
      drawSegment         : cpSpaceDebugDrawSegmentImpl;
      drawFatSegment      : cpSpaceDebugDrawFatSegmentImpl;
      drawPolygon         : cpSpaceDebugDrawPolygonImpl;
      drawDot             : cpSpaceDebugDrawDotImpl;
      flags               : cpSpaceDebugDrawFlags;
      shapeOutlineColor   : cpSpaceDebugColor;
      colorForShape       : cpSpaceDebugDrawColorForShapeImpl;
      constraintColor     : cpSpaceDebugColor;
      collisionPointColor : cpSpaceDebugColor;
      data                : cpDataPointer;
   end record
   with Convention => C_Pass_By_Copy;

   function Alloc return cpSpace;
   --
   pragma Import (C, Alloc, "cpSpaceAlloc");

   function Init (space : cpSpace) return cpSpace;
   --
   pragma Import (C, Init, "cpSpaceInit");

   function NewSpace return cpSpace;
   --
   pragma Import (C, NewSpace, "cpSpaceNew");

   procedure Destroy (space : cpSpace);
   --
   pragma Import (C, Destroy, "cpSpaceDestroy");

   procedure Free (space : cpSpace);
   --
   pragma Import (C, Free, "cpSpaceFree");

   function GetIterations (space : cpSpace) return Interfaces.C.int;
   --
   pragma Import (C, GetIterations, "cpSpaceGetIterations");

   procedure SetIterations (space : cpSpace; iterations : Interfaces.C.int);
   --
   pragma Import (C, SetIterations, "cpSpaceSetIterations");

   function GetGravity (space : cpSpace) return cpVect;
   --
   pragma Import (C, GetGravity, "cpSpaceGetGravity");

   procedure SetGravity (space : cpSpace; gravity : cpVect);
   --
   pragma Import (C, SetGravity, "cpSpaceSetGravity");

   function GetDamping (space : cpSpace) return cpFloat;
   --
   pragma Import (C, GetDamping, "cpSpaceGetDamping");

   procedure SetDamping (space : cpSpace; damping : cpFloat);
   --
   pragma Import (C, SetDamping, "cpSpaceSetDamping");

   function GetIdleSpeedThreshold (space : cpSpace) return cpFloat;
   --
   pragma Import (C, GetIdleSpeedThreshold, "cpSpaceGetIdleSpeedThreshold");

   procedure SetIdleSpeedThreshold
     (space : cpSpace; idleSpeedThreshold : cpFloat);
   --
   pragma Import (C, SetIdleSpeedThreshold, "cpSpaceSetIdleSpeedThreshold");

   function GetSleepTimeThreshold (space : cpSpace) return cpFloat;
   --
   pragma Import (C, GetSleepTimeThreshold, "cpSpaceGetSleepTimeThreshold");

   procedure SetSleepTimeThreshold
     (space : cpSpace; sleepTimeThreshold : cpFloat);
   --
   pragma Import (C, SetSleepTimeThreshold, "cpSpaceSetSleepTimeThreshold");

   function GetCollisionSlop (space : cpSpace) return cpFloat;
   --
   pragma Import (C, GetCollisionSlop, "cpSpaceGetCollisionSlop");

   procedure SetCollisionSlop (space : cpSpace; collisionSlop : cpFloat);
   --
   pragma Import (C, SetCollisionSlop, "cpSpaceSetCollisionSlop");

   function GetCollisionBias (space : cpSpace) return cpFloat;
   --
   pragma Import (C, GetCollisionBias, "cpSpaceGetCollisionBias");

   procedure SetCollisionBias (space : cpSpace; collisionBias : cpFloat);
   --
   pragma Import (C, SetCollisionBias, "cpSpaceSetCollisionBias");

   function GetCollisionPersistence (space : cpSpace) return cpTimestamp;
   --
   pragma
     Import (C, GetCollisionPersistence, "cpSpaceGetCollisionPersistence");

   procedure SetCollisionPersistence
     (space : cpSpace; collisionPersistence : cpTimestamp);
   --
   pragma
     Import (C, SetCollisionPersistence, "cpSpaceSetCollisionPersistence");

   function GetUserData (space : cpSpace) return cpDataPointer;
   --
   pragma Import (C, GetUserData, "cpSpaceGetUserData");

   procedure SetUserData (space : cpSpace; userData : cpDataPointer);
   --
   pragma Import (C, SetUserData, "cpSpaceSetUserData");

   function GetStaticBody (space : cpSpace) return cpBody;
   --
   pragma Import (C, GetStaticBody, "cpSpaceGetStaticBody");

   function GetCurrentTimeStep (space : cpSpace) return cpFloat;
   --
   pragma Import (C, GetCurrentTimeStep, "cpSpaceGetCurrentTimeStep");

   function IsLocked (space : cpSpace) return cpBool;
   --
   pragma Import (C, IsLocked, "cpSpaceIsLocked");

   function AddDefaultCollisionHandler
     (space : cpSpace) return access cpCollisionHandler;
   --
   pragma
     Import
       (C, AddDefaultCollisionHandler, "cpSpaceAddDefaultCollisionHandler");

   function AddCollisionHandler
     (space : cpSpace; a : cpCollisionType; b : cpCollisionType)
      return access cpCollisionHandler;
   --
   pragma Import (C, AddCollisionHandler, "cpSpaceAddCollisionHandler");

   function AddWildcardHandler
     (space : cpSpace; type_p : cpCollisionType)
      return access cpCollisionHandler;
   --
   pragma Import (C, AddWildcardHandler, "cpSpaceAddWildcardHandler");

   function AddShape (space : cpSpace; shape : cpShape) return cpShape;
   --
   pragma Import (C, AddShape, "cpSpaceAddShape");

   function AddBody (space : cpSpace; body_p : cpBody) return cpBody;
   --
   pragma Import (C, AddBody, "cpSpaceAddBody");

   function AddConstraint
     (space : cpSpace; constraint : cpConstraint) return cpConstraint;
   --
   pragma Import (C, AddConstraint, "cpSpaceAddConstraint");

   procedure RemoveShape (space : cpSpace; shape : cpShape);
   --
   pragma Import (C, RemoveShape, "cpSpaceRemoveShape");

   procedure RemoveBody (space : cpSpace; body_p : cpBody);
   --
   pragma Import (C, RemoveBody, "cpSpaceRemoveBody");

   procedure RemoveConstraint (space : cpSpace; constraint : cpConstraint);
   --
   pragma Import (C, RemoveConstraint, "cpSpaceRemoveConstraint");

   function ContainsShape (space : cpSpace; shape : cpShape) return cpBool;
   --
   pragma Import (C, ContainsShape, "cpSpaceContainsShape");

   function ContainsBody (space : cpSpace; body_p : cpBody) return cpBool;
   --
   pragma Import (C, ContainsBody, "cpSpaceContainsBody");

   function ContainsConstraint
     (space : cpSpace; constraint : cpConstraint) return cpBool;
   --
   pragma Import (C, ContainsConstraint, "cpSpaceContainsConstraint");

   function AddPostStepCallback
     (space : cpSpace;
      func  : cpPostStepFunc;
      key   : System.Address;
      data  : System.Address) return cpBool;
   --
   pragma Import (C, AddPostStepCallback, "cpSpaceAddPostStepCallback");

   procedure PointQuery
     (space       : cpSpace;
      point       : cpVect;
      maxDistance : cpFloat;
      filter      : cpShapeFilter;
      func        : cpSpacePointQueryFunc;
      data        : System.Address);
   --
   pragma Import (C, PointQuery, "cpSpacePointQuery");

   function PointQueryNearest
     (space       : cpSpace;
      point       : cpVect;
      maxDistance : cpFloat;
      filter      : cpShapeFilter;
      out_p       : cpPointQueryInfo) return cpShape;
   --
   pragma Import (C, PointQueryNearest, "cpSpacePointQueryNearest");

   procedure SegmentQuery
     (space  : cpSpace;
      start  : cpVect;
      end_p  : cpVect;
      radius : cpFloat;
      filter : cpShapeFilter;
      func   : cpSpaceSegmentQueryFunc;
      data   : System.Address);
   --
   pragma Import (C, SegmentQuery, "cpSpaceSegmentQuery");

   function SegmentQueryFirst
     (space  : cpSpace;
      start  : cpVect;
      end_p  : cpVect;
      radius : cpFloat;
      filter : cpShapeFilter;
      out_p  : cpSegmentQueryInfo) return cpShape;
   --
   pragma Import (C, SegmentQueryFirst, "cpSpaceSegmentQueryFirst");

   procedure BBQuery
     (space  : cpSpace;
      bb     : cpBB;
      filter : cpShapeFilter;
      func   : cpSpaceBBQueryFunc;
      data   : System.Address);
   --
   pragma Import (C, BBQuery, "cpSpaceBBQuery");

   function ShapeQuery
     (space : cpSpace;
      shape : cpShape;
      func  : cpSpaceShapeQueryFunc;
      data  : System.Address) return cpBool;
   --
   pragma Import (C, ShapeQuery, "cpSpaceShapeQuery");

   procedure EachBody
     (space : cpSpace; func : cpSpaceBodyIteratorFunc; data : System.Address);
   --
   pragma Import (C, EachBody, "cpSpaceEachBody");

   procedure EachShape
     (space : cpSpace; func : cpSpaceShapeIteratorFunc; data : System.Address);
   --
   pragma Import (C, EachShape, "cpSpaceEachShape");

   procedure EachConstraint
     (space : cpSpace;
      func  : cpSpaceConstraintIteratorFunc;
      data  : System.Address);
   --
   pragma Import (C, EachConstraint, "cpSpaceEachConstraint");

   procedure ReindexStatic (space : cpSpace);
   --
   pragma Import (C, ReindexStatic, "cpSpaceReindexStatic");

   procedure ReindexShape (space : cpSpace; shape : cpShape);
   --
   pragma Import (C, ReindexShape, "cpSpaceReindexShape");

   procedure ReindexShapesForBody (space : cpSpace; body_p : cpBody);
   --
   pragma Import (C, ReindexShapesForBody, "cpSpaceReindexShapesForBody");

   procedure UseSpatialHash
     (space : cpSpace; dim : cpFloat; count : Interfaces.C.int);
   --
   pragma Import (C, UseSpatialHash, "cpSpaceUseSpatialHash");

   procedure Step (space : cpSpace; dt : cpFloat);
   --
   pragma Import (C, Step, "cpSpaceStep");

   procedure DebugDraw
     (space : cpSpace; options : access cpSpaceDebugDrawOptions);
   --
   pragma Import (C, DebugDraw, "cpSpaceDebugDraw");

end Chipmunk.Spaces;
