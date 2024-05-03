with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Gear_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsGearJoint (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsGearJoint, "cpConstraintIsGearJoint");

   function cpGearJointAlloc return cpGearJoint;
   --  
   pragma Import (C, cpGearJointAlloc, "cpGearJointAlloc");

   function cpGearJointInit (joint : cpGearJoint; a : cpBody; b : cpBody; phase : cpFloat; ratio : cpFloat) return cpGearJoint;
   --  
   pragma Import (C, cpGearJointInit, "cpGearJointInit");

   function cpGearJointNew (a : cpBody; b : cpBody; phase : cpFloat; ratio : cpFloat) return cpConstraint;
   --  
   pragma Import (C, cpGearJointNew, "cpGearJointNew");

   function cpGearJointGetPhase (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpGearJointGetPhase, "cpGearJointGetPhase");

   procedure cpGearJointSetPhase (constraint : cpConstraint; phase : cpFloat);
   --  
   pragma Import (C, cpGearJointSetPhase, "cpGearJointSetPhase");

   function cpGearJointGetRatio (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpGearJointGetRatio, "cpGearJointGetRatio");

   procedure cpGearJointSetRatio (constraint : cpConstraint; ratio : cpFloat);
   --  
   pragma Import (C, cpGearJointSetRatio, "cpGearJointSetRatio");

end Chipmunk.Gear_Joints;
