package Chipmunk.Bodies
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   type cpBodyVelocityFunc is
     access procedure
       (body_p : cpBody; gravity : cpVect; damping : cpFloat; dt : cpFloat)

   with Convention => C;

   type cpBodyPositionFunc is access procedure  (body_p : cpBody; dt : cpFloat)

   with Convention => C;

   type cpBodyShapeIteratorFunc is
     access procedure
       (body_p : cpBody; shape : cpShape; data : System.Address)

   with Convention => C;

   type cpBodyConstraintIteratorFunc is
     access procedure
       (body_p : cpBody; constraint : cpConstraint; data : System.Address)

   with Convention => C;

   type cpBodyArbiterIteratorFunc is
     access procedure
       (body_p : cpBody; arbiter : cpArbiter; data : System.Address)

   with Convention => C;

   function Alloc return cpBody;
   --
   pragma Import (C, Alloc, "cpBodyAlloc");

   function Init
     (body_p : cpBody; mass : cpFloat; moment : cpFloat) return cpBody;
   --
   pragma Import (C, Init, "cpBodyInit");

   function NewBody (mass : cpFloat; moment : cpFloat) return cpBody;
   --
   pragma Import (C, NewBody, "cpBodyNew");

   function NewKinematic return cpBody;
   --
   pragma Import (C, NewKinematic, "cpBodyNewKinematic");

   function NewStatic return cpBody;
   --
   pragma Import (C, NewStatic, "cpBodyNewStatic");

   procedure Destroy (body_p : cpBody);
   --
   pragma Import (C, Destroy, "cpBodyDestroy");

   procedure Free (body_p : cpBody);
   --
   pragma Import (C, Free, "cpBodyFree");

   procedure Activate (body_p : cpBody);
   --
   pragma Import (C, Activate, "cpBodyActivate");

   procedure ActivateStatic (body_p : cpBody; filter : cpShape);
   --
   pragma Import (C, ActivateStatic, "cpBodyActivateStatic");

   procedure Sleep (body_p : cpBody);
   --
   pragma Import (C, Sleep, "cpBodySleep");

   procedure SleepWithGroup (body_p : cpBody; group : cpBody);
   --
   pragma Import (C, SleepWithGroup, "cpBodySleepWithGroup");

   function IsSleeping (body_p : cpBody) return cpBool;
   --
   pragma Import (C, IsSleeping, "cpBodyIsSleeping");

   function GetType (body_p : cpBody) return cpBodyType;
   --
   pragma Import (C, GetType, "cpBodyGetType");

   procedure SetType (body_p : cpBody; type_p : cpBodyType);
   --
   pragma Import (C, SetType, "cpBodySetType");

   function GetSpace (body_p : cpBody) return cpSpace;
   --
   pragma Import (C, GetSpace, "cpBodyGetSpace");

   function GetMass (body_p : cpBody) return cpFloat;
   --
   pragma Import (C, GetMass, "cpBodyGetMass");

   procedure SetMass (body_p : cpBody; m : cpFloat);
   --
   pragma Import (C, SetMass, "cpBodySetMass");

   function GetMoment (body_p : cpBody) return cpFloat;
   --
   pragma Import (C, GetMoment, "cpBodyGetMoment");

   procedure SetMoment (body_p : cpBody; i : cpFloat);
   --
   pragma Import (C, SetMoment, "cpBodySetMoment");

   function GetPosition (body_p : cpBody) return cpVect;
   --
   pragma Import (C, GetPosition, "cpBodyGetPosition");

   procedure SetPosition (body_p : cpBody; pos : cpVect);
   --
   pragma Import (C, SetPosition, "cpBodySetPosition");

   function GetCenterOfGravity (body_p : cpBody) return cpVect;
   --
   pragma Import (C, GetCenterOfGravity, "cpBodyGetCenterOfGravity");

   procedure SetCenterOfGravity (body_p : cpBody; cog : cpVect);
   --
   pragma Import (C, SetCenterOfGravity, "cpBodySetCenterOfGravity");

   function GetVelocity (body_p : cpBody) return cpVect;
   --
   pragma Import (C, GetVelocity, "cpBodyGetVelocity");

   procedure SetVelocity (body_p : cpBody; velocity : cpVect);
   --
   pragma Import (C, SetVelocity, "cpBodySetVelocity");

   function GetForce (body_p : cpBody) return cpVect;
   --
   pragma Import (C, GetForce, "cpBodyGetForce");

   procedure SetForce (body_p : cpBody; force : cpVect);
   --
   pragma Import (C, SetForce, "cpBodySetForce");

   function GetAngle (body_p : cpBody) return cpFloat;
   --
   pragma Import (C, GetAngle, "cpBodyGetAngle");

   procedure SetAngle (body_p : cpBody; a : cpFloat);
   --
   pragma Import (C, SetAngle, "cpBodySetAngle");

   function GetAngularVelocity (body_p : cpBody) return cpFloat;
   --
   pragma Import (C, GetAngularVelocity, "cpBodyGetAngularVelocity");

   procedure SetAngularVelocity (body_p : cpBody; angularVelocity : cpFloat);
   --
   pragma Import (C, SetAngularVelocity, "cpBodySetAngularVelocity");

   function GetTorque (body_p : cpBody) return cpFloat;
   --
   pragma Import (C, GetTorque, "cpBodyGetTorque");

   procedure SetTorque (body_p : cpBody; torque : cpFloat);
   --
   pragma Import (C, SetTorque, "cpBodySetTorque");

   function GetRotation (body_p : cpBody) return cpVect;
   --
   pragma Import (C, GetRotation, "cpBodyGetRotation");

   function GetUserData (body_p : cpBody) return cpDataPointer;
   --
   pragma Import (C, GetUserData, "cpBodyGetUserData");

   procedure SetUserData (body_p : cpBody; userData : cpDataPointer);
   --
   pragma Import (C, SetUserData, "cpBodySetUserData");

   procedure SetVelocityUpdateFunc
     (body_p : cpBody; velocityFunc : cpBodyVelocityFunc);
   --
   pragma Import (C, SetVelocityUpdateFunc, "cpBodySetVelocityUpdateFunc");

   procedure SetPositionUpdateFunc
     (body_p : cpBody; positionFunc : cpBodyPositionFunc);
   --
   pragma Import (C, SetPositionUpdateFunc, "cpBodySetPositionUpdateFunc");

   procedure UpdateVelocity
     (body_p : cpBody; gravity : cpVect; damping : cpFloat; dt : cpFloat);
   --
   pragma Import (C, UpdateVelocity, "cpBodyUpdateVelocity");

   procedure UpdatePosition (body_p : cpBody; dt : cpFloat);
   --
   pragma Import (C, UpdatePosition, "cpBodyUpdatePosition");

   function LocalToWorld (body_p : cpBody; point : cpVect) return cpVect;
   --
   pragma Import (C, LocalToWorld, "cpBodyLocalToWorld");

   function WorldToLocal (body_p : cpBody; point : cpVect) return cpVect;
   --
   pragma Import (C, WorldToLocal, "cpBodyWorldToLocal");

   procedure ApplyForceAtWorldPoint
     (body_p : cpBody; force : cpVect; point : cpVect);
   --
   pragma Import (C, ApplyForceAtWorldPoint, "cpBodyApplyForceAtWorldPoint");

   procedure ApplyForceAtLocalPoint
     (body_p : cpBody; force : cpVect; point : cpVect);
   --
   pragma Import (C, ApplyForceAtLocalPoint, "cpBodyApplyForceAtLocalPoint");

   procedure ApplyImpulseAtWorldPoint
     (body_p : cpBody; impulse : cpVect; point : cpVect);
   --
   pragma
     Import (C, ApplyImpulseAtWorldPoint, "cpBodyApplyImpulseAtWorldPoint");

   procedure ApplyImpulseAtLocalPoint
     (body_p : cpBody; impulse : cpVect; point : cpVect);
   --
   pragma
     Import (C, ApplyImpulseAtLocalPoint, "cpBodyApplyImpulseAtLocalPoint");

   function GetVelocityAtWorldPoint
     (body_p : cpBody; point : cpVect) return cpVect;
   --
   pragma Import (C, GetVelocityAtWorldPoint, "cpBodyGetVelocityAtWorldPoint");

   function GetVelocityAtLocalPoint
     (body_p : cpBody; point : cpVect) return cpVect;
   --
   pragma Import (C, GetVelocityAtLocalPoint, "cpBodyGetVelocityAtLocalPoint");

   function KineticEnergy (body_p : cpBody) return cpFloat;
   --
   pragma Import (C, KineticEnergy, "cpBodyKineticEnergy");

   procedure EachShape
     (body_p : cpBody; func : cpBodyShapeIteratorFunc; data : System.Address);
   --
   pragma Import (C, EachShape, "cpBodyEachShape");

   procedure EachConstraint
     (body_p : cpBody;
      func   : cpBodyConstraintIteratorFunc;
      data   : System.Address);
   --
   pragma Import (C, EachConstraint, "cpBodyEachConstraint");

   procedure EachArbiter
     (body_p : cpBody;
      func   : cpBodyArbiterIteratorFunc;
      data   : System.Address);
   --
   pragma Import (C, EachArbiter, "cpBodyEachArbiter");

end Chipmunk.Bodies;
