with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Arbiters
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpArbiterGetRestitution (arb : cpArbiter) return cpFloat;
   --  
   pragma Import (C, cpArbiterGetRestitution, "cpArbiterGetRestitution");

   procedure cpArbiterSetRestitution (arb : cpArbiter; restitution : cpFloat);
   --  
   pragma Import (C, cpArbiterSetRestitution, "cpArbiterSetRestitution");

   function cpArbiterGetFriction (arb : cpArbiter) return cpFloat;
   --  
   pragma Import (C, cpArbiterGetFriction, "cpArbiterGetFriction");

   procedure cpArbiterSetFriction (arb : cpArbiter; friction : cpFloat);
   --  
   pragma Import (C, cpArbiterSetFriction, "cpArbiterSetFriction");

   function cpArbiterGetSurfaceVelocity (arb : cpArbiter) return cpVect;
   --  
   pragma Import (C, cpArbiterGetSurfaceVelocity, "cpArbiterGetSurfaceVelocity");

   procedure cpArbiterSetSurfaceVelocity (arb : cpArbiter; vr : cpVect);
   --  
   pragma Import (C, cpArbiterSetSurfaceVelocity, "cpArbiterSetSurfaceVelocity");

   function cpArbiterGetUserData (arb : cpArbiter) return cpDataPointer;
   --  
   pragma Import (C, cpArbiterGetUserData, "cpArbiterGetUserData");

   procedure cpArbiterSetUserData (arb : cpArbiter; userData : cpDataPointer);
   --  
   pragma Import (C, cpArbiterSetUserData, "cpArbiterSetUserData");

   function cpArbiterTotalImpulse (arb : cpArbiter) return cpVect;
   --  
   pragma Import (C, cpArbiterTotalImpulse, "cpArbiterTotalImpulse");

   function cpArbiterTotalKE (arb : cpArbiter) return cpFloat;
   --  
   pragma Import (C, cpArbiterTotalKE, "cpArbiterTotalKE");

   function cpArbiterIgnore (arb : cpArbiter) return cpBool;
   --  
   pragma Import (C, cpArbiterIgnore, "cpArbiterIgnore");

   procedure cpArbiterGetShapes (arb : cpArbiter; a : access cpShape; b : access cpShape);
   --  
   pragma Import (C, cpArbiterGetShapes, "cpArbiterGetShapes");

   procedure cpArbiterGetBodies (arb : cpArbiter; a : access cpBody; b : access cpBody);
   --  
   pragma Import (C, cpArbiterGetBodies, "cpArbiterGetBodies");

   function cpArbiterGetContactPointSet (arb : cpArbiter) return cpContactPointSet;
   --  
   pragma Import (C, cpArbiterGetContactPointSet, "cpArbiterGetContactPointSet");

   procedure cpArbiterSetContactPointSet (arb : cpArbiter; set : access cpContactPointSet);
   --  
   pragma Import (C, cpArbiterSetContactPointSet, "cpArbiterSetContactPointSet");

   function cpArbiterIsFirstContact (arb : cpArbiter) return cpBool;
   --  
   pragma Import (C, cpArbiterIsFirstContact, "cpArbiterIsFirstContact");

   function cpArbiterIsRemoval (arb : cpArbiter) return cpBool;
   --  
   pragma Import (C, cpArbiterIsRemoval, "cpArbiterIsRemoval");

   function cpArbiterGetCount (arb : cpArbiter) return Interfaces.C.int;
   --  
   pragma Import (C, cpArbiterGetCount, "cpArbiterGetCount");

   function cpArbiterGetNormal (arb : cpArbiter) return cpVect;
   --  
   pragma Import (C, cpArbiterGetNormal, "cpArbiterGetNormal");

   function cpArbiterGetPointA (arb : cpArbiter; i : Interfaces.C.int) return cpVect;
   --  
   pragma Import (C, cpArbiterGetPointA, "cpArbiterGetPointA");

   function cpArbiterGetPointB (arb : cpArbiter; i : Interfaces.C.int) return cpVect;
   --  
   pragma Import (C, cpArbiterGetPointB, "cpArbiterGetPointB");

   function cpArbiterGetDepth (arb : cpArbiter; i : Interfaces.C.int) return cpFloat;
   --  
   pragma Import (C, cpArbiterGetDepth, "cpArbiterGetDepth");

   function cpArbiterCallWildcardBeginA (arb : cpArbiter; space : cpSpace) return cpBool;
   --  
   pragma Import (C, cpArbiterCallWildcardBeginA, "cpArbiterCallWildcardBeginA");

   function cpArbiterCallWildcardBeginB (arb : cpArbiter; space : cpSpace) return cpBool;
   --  
   pragma Import (C, cpArbiterCallWildcardBeginB, "cpArbiterCallWildcardBeginB");

   function cpArbiterCallWildcardPreSolveA (arb : cpArbiter; space : cpSpace) return cpBool;
   --  
   pragma Import (C, cpArbiterCallWildcardPreSolveA, "cpArbiterCallWildcardPreSolveA");

   function cpArbiterCallWildcardPreSolveB (arb : cpArbiter; space : cpSpace) return cpBool;
   --  
   pragma Import (C, cpArbiterCallWildcardPreSolveB, "cpArbiterCallWildcardPreSolveB");

   procedure cpArbiterCallWildcardPostSolveA (arb : cpArbiter; space : cpSpace);
   --  
   pragma Import (C, cpArbiterCallWildcardPostSolveA, "cpArbiterCallWildcardPostSolveA");

   procedure cpArbiterCallWildcardPostSolveB (arb : cpArbiter; space : cpSpace);
   --  
   pragma Import (C, cpArbiterCallWildcardPostSolveB, "cpArbiterCallWildcardPostSolveB");

   procedure cpArbiterCallWildcardSeparateA (arb : cpArbiter; space : cpSpace);
   --  
   pragma Import (C, cpArbiterCallWildcardSeparateA, "cpArbiterCallWildcardSeparateA");

   procedure cpArbiterCallWildcardSeparateB (arb : cpArbiter; space : cpSpace);
   --  
   pragma Import (C, cpArbiterCallWildcardSeparateB, "cpArbiterCallWildcardSeparateB");

   CP_MAX_CONTACTS_PER_ARBITER : constant := 2;
end Chipmunk.Arbiters;
