with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Ratchet_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsRatchetJoint (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsRatchetJoint, "cpConstraintIsRatchetJoint");

   function cpRatchetJointAlloc return cpRatchetJoint;
   --  
   pragma Import (C, cpRatchetJointAlloc, "cpRatchetJointAlloc");

   function cpRatchetJointInit (joint : cpRatchetJoint; a : cpBody; b : cpBody; phase : cpFloat; ratchet : cpFloat) return cpRatchetJoint;
   --  
   pragma Import (C, cpRatchetJointInit, "cpRatchetJointInit");

   function cpRatchetJointNew (a : cpBody; b : cpBody; phase : cpFloat; ratchet : cpFloat) return cpConstraint;
   --  
   pragma Import (C, cpRatchetJointNew, "cpRatchetJointNew");

   function cpRatchetJointGetAngle (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpRatchetJointGetAngle, "cpRatchetJointGetAngle");

   procedure cpRatchetJointSetAngle (constraint : cpConstraint; angle : cpFloat);
   --  
   pragma Import (C, cpRatchetJointSetAngle, "cpRatchetJointSetAngle");

   function cpRatchetJointGetPhase (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpRatchetJointGetPhase, "cpRatchetJointGetPhase");

   procedure cpRatchetJointSetPhase (constraint : cpConstraint; phase : cpFloat);
   --  
   pragma Import (C, cpRatchetJointSetPhase, "cpRatchetJointSetPhase");

   function cpRatchetJointGetRatchet (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpRatchetJointGetRatchet, "cpRatchetJointGetRatchet");

   procedure cpRatchetJointSetRatchet (constraint : cpConstraint; ratchet : cpFloat);
   --  
   pragma Import (C, cpRatchetJointSetRatchet, "cpRatchetJointSetRatchet");

end Chipmunk.Ratchet_Joints;
