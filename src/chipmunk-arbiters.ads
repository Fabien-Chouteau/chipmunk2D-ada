with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Arbiters
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function GetRestitution (arb : cpArbiter) return cpFloat;
   --  
   pragma Import (C, GetRestitution, "cpArbiterGetRestitution");

   procedure SetRestitution (arb : cpArbiter; restitution : cpFloat);
   --  
   pragma Import (C, SetRestitution, "cpArbiterSetRestitution");

   function GetFriction (arb : cpArbiter) return cpFloat;
   --  
   pragma Import (C, GetFriction, "cpArbiterGetFriction");

   procedure SetFriction (arb : cpArbiter; friction : cpFloat);
   --  
   pragma Import (C, SetFriction, "cpArbiterSetFriction");

   function GetSurfaceVelocity (arb : cpArbiter) return cpVect;
   --  
   pragma Import (C, GetSurfaceVelocity, "cpArbiterGetSurfaceVelocity");

   procedure SetSurfaceVelocity (arb : cpArbiter; vr : cpVect);
   --  
   pragma Import (C, SetSurfaceVelocity, "cpArbiterSetSurfaceVelocity");

   function GetUserData (arb : cpArbiter) return cpDataPointer;
   --  
   pragma Import (C, GetUserData, "cpArbiterGetUserData");

   procedure SetUserData (arb : cpArbiter; userData : cpDataPointer);
   --  
   pragma Import (C, SetUserData, "cpArbiterSetUserData");

   function TotalImpulse (arb : cpArbiter) return cpVect;
   --  
   pragma Import (C, TotalImpulse, "cpArbiterTotalImpulse");

   function TotalKE (arb : cpArbiter) return cpFloat;
   --  
   pragma Import (C, TotalKE, "cpArbiterTotalKE");

   function Ignore (arb : cpArbiter) return cpBool;
   --  
   pragma Import (C, Ignore, "cpArbiterIgnore");

   procedure GetShapes (arb : cpArbiter; a : access cpShape; b : access cpShape);
   --  
   pragma Import (C, GetShapes, "cpArbiterGetShapes");

   procedure GetBodies (arb : cpArbiter; a : access cpBody; b : access cpBody);
   --  
   pragma Import (C, GetBodies, "cpArbiterGetBodies");

   function GetContactPointSet (arb : cpArbiter) return cpContactPointSet;
   --  
   pragma Import (C, GetContactPointSet, "cpArbiterGetContactPointSet");

   procedure SetContactPointSet (arb : cpArbiter; set : access cpContactPointSet);
   --  
   pragma Import (C, SetContactPointSet, "cpArbiterSetContactPointSet");

   function IsFirstContact (arb : cpArbiter) return cpBool;
   --  
   pragma Import (C, IsFirstContact, "cpArbiterIsFirstContact");

   function IsRemoval (arb : cpArbiter) return cpBool;
   --  
   pragma Import (C, IsRemoval, "cpArbiterIsRemoval");

   function GetCount (arb : cpArbiter) return Interfaces.C.int;
   --  
   pragma Import (C, GetCount, "cpArbiterGetCount");

   function GetNormal (arb : cpArbiter) return cpVect;
   --  
   pragma Import (C, GetNormal, "cpArbiterGetNormal");

   function GetPointA (arb : cpArbiter; i : Interfaces.C.int) return cpVect;
   --  
   pragma Import (C, GetPointA, "cpArbiterGetPointA");

   function GetPointB (arb : cpArbiter; i : Interfaces.C.int) return cpVect;
   --  
   pragma Import (C, GetPointB, "cpArbiterGetPointB");

   function GetDepth (arb : cpArbiter; i : Interfaces.C.int) return cpFloat;
   --  
   pragma Import (C, GetDepth, "cpArbiterGetDepth");

   function CallWildcardBeginA (arb : cpArbiter; space : cpSpace) return cpBool;
   --  
   pragma Import (C, CallWildcardBeginA, "cpArbiterCallWildcardBeginA");

   function CallWildcardBeginB (arb : cpArbiter; space : cpSpace) return cpBool;
   --  
   pragma Import (C, CallWildcardBeginB, "cpArbiterCallWildcardBeginB");

   function CallWildcardPreSolveA (arb : cpArbiter; space : cpSpace) return cpBool;
   --  
   pragma Import (C, CallWildcardPreSolveA, "cpArbiterCallWildcardPreSolveA");

   function CallWildcardPreSolveB (arb : cpArbiter; space : cpSpace) return cpBool;
   --  
   pragma Import (C, CallWildcardPreSolveB, "cpArbiterCallWildcardPreSolveB");

   procedure CallWildcardPostSolveA (arb : cpArbiter; space : cpSpace);
   --  
   pragma Import (C, CallWildcardPostSolveA, "cpArbiterCallWildcardPostSolveA");

   procedure CallWildcardPostSolveB (arb : cpArbiter; space : cpSpace);
   --  
   pragma Import (C, CallWildcardPostSolveB, "cpArbiterCallWildcardPostSolveB");

   procedure CallWildcardSeparateA (arb : cpArbiter; space : cpSpace);
   --  
   pragma Import (C, CallWildcardSeparateA, "cpArbiterCallWildcardSeparateA");

   procedure CallWildcardSeparateB (arb : cpArbiter; space : cpSpace);
   --  
   pragma Import (C, CallWildcardSeparateB, "cpArbiterCallWildcardSeparateB");

   CP_MAX_CONTACTS_PER_ARBITER : constant := 2;
end Chipmunk.Arbiters;
