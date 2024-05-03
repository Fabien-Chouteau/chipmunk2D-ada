with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Groove_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsGrooveJoint (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsGrooveJoint, "cpConstraintIsGrooveJoint");

   function cpGrooveJointAlloc return cpGrooveJoint;
   --  
   pragma Import (C, cpGrooveJointAlloc, "cpGrooveJointAlloc");

   function cpGrooveJointInit (joint : cpGrooveJoint; a : cpBody; b : cpBody; groove_a : cpVect; groove_b : cpVect; anchorB : cpVect) return cpGrooveJoint;
   --  
   pragma Import (C, cpGrooveJointInit, "cpGrooveJointInit");

   function cpGrooveJointNew (a : cpBody; b : cpBody; groove_a : cpVect; groove_b : cpVect; anchorB : cpVect) return cpConstraint;
   --  
   pragma Import (C, cpGrooveJointNew, "cpGrooveJointNew");

   function cpGrooveJointGetGrooveA (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, cpGrooveJointGetGrooveA, "cpGrooveJointGetGrooveA");

   procedure cpGrooveJointSetGrooveA (constraint : cpConstraint; grooveA : cpVect);
   --  
   pragma Import (C, cpGrooveJointSetGrooveA, "cpGrooveJointSetGrooveA");

   function cpGrooveJointGetGrooveB (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, cpGrooveJointGetGrooveB, "cpGrooveJointGetGrooveB");

   procedure cpGrooveJointSetGrooveB (constraint : cpConstraint; grooveB : cpVect);
   --  
   pragma Import (C, cpGrooveJointSetGrooveB, "cpGrooveJointSetGrooveB");

   function cpGrooveJointGetAnchorB (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, cpGrooveJointGetAnchorB, "cpGrooveJointGetAnchorB");

   procedure cpGrooveJointSetAnchorB (constraint : cpConstraint; anchorB : cpVect);
   --  
   pragma Import (C, cpGrooveJointSetAnchorB, "cpGrooveJointSetAnchorB");

end Chipmunk.Groove_Joints;
