package Chipmunk.Groove_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsGrooveJoint
     (constraint : cpConstraint) return cpBool;
   --
   pragma Import (C, cpConstraintIsGrooveJoint, "cpConstraintIsGrooveJoint");

   function Alloc return cpGrooveJoint;
   --
   pragma Import (C, Alloc, "cpGrooveJointAlloc");

   function Init
     (joint    : cpGrooveJoint;
      a        : cpBody;
      b        : cpBody;
      groove_a : cpVect;
      groove_b : cpVect;
      anchorB  : cpVect) return cpGrooveJoint;
   --
   pragma Import (C, Init, "cpGrooveJointInit");

   function NewGrooveJoint
     (a        : cpBody;
      b        : cpBody;
      groove_a : cpVect;
      groove_b : cpVect;
      anchorB  : cpVect) return cpConstraint;
   --
   pragma Import (C, NewGrooveJoint, "cpGrooveJointNew");

   function GetGrooveA (constraint : cpConstraint) return cpVect;
   --
   pragma Import (C, GetGrooveA, "cpGrooveJointGetGrooveA");

   procedure SetGrooveA (constraint : cpConstraint; grooveA : cpVect);
   --
   pragma Import (C, SetGrooveA, "cpGrooveJointSetGrooveA");

   function GetGrooveB (constraint : cpConstraint) return cpVect;
   --
   pragma Import (C, GetGrooveB, "cpGrooveJointGetGrooveB");

   procedure SetGrooveB (constraint : cpConstraint; grooveB : cpVect);
   --
   pragma Import (C, SetGrooveB, "cpGrooveJointSetGrooveB");

   function GetAnchorB (constraint : cpConstraint) return cpVect;
   --
   pragma Import (C, GetAnchorB, "cpGrooveJointGetAnchorB");

   procedure SetAnchorB (constraint : cpConstraint; anchorB : cpVect);
   --
   pragma Import (C, SetAnchorB, "cpGrooveJointSetAnchorB");

end Chipmunk.Groove_Joints;
