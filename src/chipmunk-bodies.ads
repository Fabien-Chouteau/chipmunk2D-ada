with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Bodies
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   type cpBodyVelocityFunc is access    procedure  (body_p : cpBody; gravity : cpVect; damping : cpFloat; dt : cpFloat)

     with Convention => C;

   type cpBodyPositionFunc is access    procedure  (body_p : cpBody; dt : cpFloat)

     with Convention => C;

   type cpBodyShapeIteratorFunc is access    procedure  (body_p : cpBody; shape : cpShape; data : System.Address)

     with Convention => C;

   type cpBodyConstraintIteratorFunc is access    procedure  (body_p : cpBody; constraint : cpConstraint; data : System.Address)

     with Convention => C;

   type cpBodyArbiterIteratorFunc is access    procedure  (body_p : cpBody; arbiter : cpArbiter; data : System.Address)

     with Convention => C;

   function cpBodyAlloc return cpBody;
   --  
   pragma Import (C, cpBodyAlloc, "cpBodyAlloc");

   function cpBodyInit (body_p : cpBody; mass : cpFloat; moment : cpFloat) return cpBody;
   --  
   pragma Import (C, cpBodyInit, "cpBodyInit");

   function cpBodyNew (mass : cpFloat; moment : cpFloat) return cpBody;
   --  
   pragma Import (C, cpBodyNew, "cpBodyNew");

   function cpBodyNewKinematic return cpBody;
   --  
   pragma Import (C, cpBodyNewKinematic, "cpBodyNewKinematic");

   function cpBodyNewStatic return cpBody;
   --  
   pragma Import (C, cpBodyNewStatic, "cpBodyNewStatic");

   procedure cpBodyDestroy (body_p : cpBody);
   --  
   pragma Import (C, cpBodyDestroy, "cpBodyDestroy");

   procedure cpBodyFree (body_p : cpBody);
   --  
   pragma Import (C, cpBodyFree, "cpBodyFree");

   procedure cpBodyActivate (body_p : cpBody);
   --  
   pragma Import (C, cpBodyActivate, "cpBodyActivate");

   procedure cpBodyActivateStatic (body_p : cpBody; filter : cpShape);
   --  
   pragma Import (C, cpBodyActivateStatic, "cpBodyActivateStatic");

   procedure cpBodySleep (body_p : cpBody);
   --  
   pragma Import (C, cpBodySleep, "cpBodySleep");

   procedure cpBodySleepWithGroup (body_p : cpBody; group : cpBody);
   --  
   pragma Import (C, cpBodySleepWithGroup, "cpBodySleepWithGroup");

   function cpBodyIsSleeping (body_p : cpBody) return cpBool;
   --  
   pragma Import (C, cpBodyIsSleeping, "cpBodyIsSleeping");

   function cpBodyGetType (body_p : cpBody) return cpBodyType;
   --  
   pragma Import (C, cpBodyGetType, "cpBodyGetType");

   procedure cpBodySetType (body_p : cpBody; type_p : cpBodyType);
   --  
   pragma Import (C, cpBodySetType, "cpBodySetType");

   function cpBodyGetSpace (body_p : cpBody) return cpSpace;
   --  
   pragma Import (C, cpBodyGetSpace, "cpBodyGetSpace");

   function cpBodyGetMass (body_p : cpBody) return cpFloat;
   --  
   pragma Import (C, cpBodyGetMass, "cpBodyGetMass");

   procedure cpBodySetMass (body_p : cpBody; m : cpFloat);
   --  
   pragma Import (C, cpBodySetMass, "cpBodySetMass");

   function cpBodyGetMoment (body_p : cpBody) return cpFloat;
   --  
   pragma Import (C, cpBodyGetMoment, "cpBodyGetMoment");

   procedure cpBodySetMoment (body_p : cpBody; i : cpFloat);
   --  
   pragma Import (C, cpBodySetMoment, "cpBodySetMoment");

   function cpBodyGetPosition (body_p : cpBody) return cpVect;
   --  
   pragma Import (C, cpBodyGetPosition, "cpBodyGetPosition");

   procedure cpBodySetPosition (body_p : cpBody; pos : cpVect);
   --  
   pragma Import (C, cpBodySetPosition, "cpBodySetPosition");

   function cpBodyGetCenterOfGravity (body_p : cpBody) return cpVect;
   --  
   pragma Import (C, cpBodyGetCenterOfGravity, "cpBodyGetCenterOfGravity");

   procedure cpBodySetCenterOfGravity (body_p : cpBody; cog : cpVect);
   --  
   pragma Import (C, cpBodySetCenterOfGravity, "cpBodySetCenterOfGravity");

   function cpBodyGetVelocity (body_p : cpBody) return cpVect;
   --  
   pragma Import (C, cpBodyGetVelocity, "cpBodyGetVelocity");

   procedure cpBodySetVelocity (body_p : cpBody; velocity : cpVect);
   --  
   pragma Import (C, cpBodySetVelocity, "cpBodySetVelocity");

   function cpBodyGetForce (body_p : cpBody) return cpVect;
   --  
   pragma Import (C, cpBodyGetForce, "cpBodyGetForce");

   procedure cpBodySetForce (body_p : cpBody; force : cpVect);
   --  
   pragma Import (C, cpBodySetForce, "cpBodySetForce");

   function cpBodyGetAngle (body_p : cpBody) return cpFloat;
   --  
   pragma Import (C, cpBodyGetAngle, "cpBodyGetAngle");

   procedure cpBodySetAngle (body_p : cpBody; a : cpFloat);
   --  
   pragma Import (C, cpBodySetAngle, "cpBodySetAngle");

   function cpBodyGetAngularVelocity (body_p : cpBody) return cpFloat;
   --  
   pragma Import (C, cpBodyGetAngularVelocity, "cpBodyGetAngularVelocity");

   procedure cpBodySetAngularVelocity (body_p : cpBody; angularVelocity : cpFloat);
   --  
   pragma Import (C, cpBodySetAngularVelocity, "cpBodySetAngularVelocity");

   function cpBodyGetTorque (body_p : cpBody) return cpFloat;
   --  
   pragma Import (C, cpBodyGetTorque, "cpBodyGetTorque");

   procedure cpBodySetTorque (body_p : cpBody; torque : cpFloat);
   --  
   pragma Import (C, cpBodySetTorque, "cpBodySetTorque");

   function cpBodyGetRotation (body_p : cpBody) return cpVect;
   --  
   pragma Import (C, cpBodyGetRotation, "cpBodyGetRotation");

   function cpBodyGetUserData (body_p : cpBody) return cpDataPointer;
   --  
   pragma Import (C, cpBodyGetUserData, "cpBodyGetUserData");

   procedure cpBodySetUserData (body_p : cpBody; userData : cpDataPointer);
   --  
   pragma Import (C, cpBodySetUserData, "cpBodySetUserData");

   procedure cpBodySetVelocityUpdateFunc (body_p : cpBody; velocityFunc : cpBodyVelocityFunc);
   --  
   pragma Import (C, cpBodySetVelocityUpdateFunc, "cpBodySetVelocityUpdateFunc");

   procedure cpBodySetPositionUpdateFunc (body_p : cpBody; positionFunc : cpBodyPositionFunc);
   --  
   pragma Import (C, cpBodySetPositionUpdateFunc, "cpBodySetPositionUpdateFunc");

   procedure cpBodyUpdateVelocity (body_p : cpBody; gravity : cpVect; damping : cpFloat; dt : cpFloat);
   --  
   pragma Import (C, cpBodyUpdateVelocity, "cpBodyUpdateVelocity");

   procedure cpBodyUpdatePosition (body_p : cpBody; dt : cpFloat);
   --  
   pragma Import (C, cpBodyUpdatePosition, "cpBodyUpdatePosition");

   function cpBodyLocalToWorld (body_p : cpBody; point : cpVect) return cpVect;
   --  
   pragma Import (C, cpBodyLocalToWorld, "cpBodyLocalToWorld");

   function cpBodyWorldToLocal (body_p : cpBody; point : cpVect) return cpVect;
   --  
   pragma Import (C, cpBodyWorldToLocal, "cpBodyWorldToLocal");

   procedure cpBodyApplyForceAtWorldPoint (body_p : cpBody; force : cpVect; point : cpVect);
   --  
   pragma Import (C, cpBodyApplyForceAtWorldPoint, "cpBodyApplyForceAtWorldPoint");

   procedure cpBodyApplyForceAtLocalPoint (body_p : cpBody; force : cpVect; point : cpVect);
   --  
   pragma Import (C, cpBodyApplyForceAtLocalPoint, "cpBodyApplyForceAtLocalPoint");

   procedure cpBodyApplyImpulseAtWorldPoint (body_p : cpBody; impulse : cpVect; point : cpVect);
   --  
   pragma Import (C, cpBodyApplyImpulseAtWorldPoint, "cpBodyApplyImpulseAtWorldPoint");

   procedure cpBodyApplyImpulseAtLocalPoint (body_p : cpBody; impulse : cpVect; point : cpVect);
   --  
   pragma Import (C, cpBodyApplyImpulseAtLocalPoint, "cpBodyApplyImpulseAtLocalPoint");

   function cpBodyGetVelocityAtWorldPoint (body_p : cpBody; point : cpVect) return cpVect;
   --  
   pragma Import (C, cpBodyGetVelocityAtWorldPoint, "cpBodyGetVelocityAtWorldPoint");

   function cpBodyGetVelocityAtLocalPoint (body_p : cpBody; point : cpVect) return cpVect;
   --  
   pragma Import (C, cpBodyGetVelocityAtLocalPoint, "cpBodyGetVelocityAtLocalPoint");

   function cpBodyKineticEnergy (body_p : cpBody) return cpFloat;
   --  
   pragma Import (C, cpBodyKineticEnergy, "cpBodyKineticEnergy");

   procedure cpBodyEachShape (body_p : cpBody; func : cpBodyShapeIteratorFunc; data : System.Address);
   --  
   pragma Import (C, cpBodyEachShape, "cpBodyEachShape");

   procedure cpBodyEachConstraint (body_p : cpBody; func : cpBodyConstraintIteratorFunc; data : System.Address);
   --  
   pragma Import (C, cpBodyEachConstraint, "cpBodyEachConstraint");

   procedure cpBodyEachArbiter (body_p : cpBody; func : cpBodyArbiterIteratorFunc; data : System.Address);
   --  
   pragma Import (C, cpBodyEachArbiter, "cpBodyEachArbiter");

end Chipmunk.Bodies;
