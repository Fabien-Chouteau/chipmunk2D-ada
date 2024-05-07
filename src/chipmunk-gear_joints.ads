with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Gear_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsGearJoint (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsGearJoint, "cpConstraintIsGearJoint");

   function tAlloc return cpGearJoint;
   --  
   pragma Import (C, tAlloc, "cpGearJointAlloc");

   function tInit (joint : cpGearJoint; a : cpBody; b : cpBody; phase : cpFloat; ratio : cpFloat) return cpGearJoint;
   --  
   pragma Import (C, tInit, "cpGearJointInit");

   function tNew (a : cpBody; b : cpBody; phase : cpFloat; ratio : cpFloat) return cpConstraint;
   --  
   pragma Import (C, tNew, "cpGearJointNew");

   function tGetPhase (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, tGetPhase, "cpGearJointGetPhase");

   procedure tSetPhase (constraint : cpConstraint; phase : cpFloat);
   --  
   pragma Import (C, tSetPhase, "cpGearJointSetPhase");

   function tGetRatio (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, tGetRatio, "cpGearJointGetRatio");

   procedure tSetRatio (constraint : cpConstraint; ratio : cpFloat);
   --  
   pragma Import (C, tSetRatio, "cpGearJointSetRatio");

end Chipmunk.Gear_Joints;
