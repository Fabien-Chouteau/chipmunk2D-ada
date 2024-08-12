package Chipmunk.Ratchet_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsRatchetJoint
     (constraint : cpConstraint) return cpBool;
   --
   pragma Import (C, cpConstraintIsRatchetJoint, "cpConstraintIsRatchetJoint");

   function Alloc return cpRatchetJoint;
   --
   pragma Import (C, Alloc, "cpRatchetJointAlloc");

   function Init
     (joint   : cpRatchetJoint;
      a       : cpBody;
      b       : cpBody;
      phase   : cpFloat;
      ratchet : cpFloat) return cpRatchetJoint;
   --
   pragma Import (C, Init, "cpRatchetJointInit");

   function NewRatchetJoint
     (a : cpBody; b : cpBody; phase : cpFloat; ratchet : cpFloat)
      return cpConstraint;
   --
   pragma Import (C, NewRatchetJoint, "cpRatchetJointNew");

   function GetAngle (constraint : cpConstraint) return cpFloat;
   --
   pragma Import (C, GetAngle, "cpRatchetJointGetAngle");

   procedure SetAngle (constraint : cpConstraint; angle : cpFloat);
   --
   pragma Import (C, SetAngle, "cpRatchetJointSetAngle");

   function GetPhase (constraint : cpConstraint) return cpFloat;
   --
   pragma Import (C, GetPhase, "cpRatchetJointGetPhase");

   procedure SetPhase (constraint : cpConstraint; phase : cpFloat);
   --
   pragma Import (C, SetPhase, "cpRatchetJointSetPhase");

   function GetRatchet (constraint : cpConstraint) return cpFloat;
   --
   pragma Import (C, GetRatchet, "cpRatchetJointGetRatchet");

   procedure SetRatchet (constraint : cpConstraint; ratchet : cpFloat);
   --
   pragma Import (C, SetRatchet, "cpRatchetJointSetRatchet");

end Chipmunk.Ratchet_Joints;
