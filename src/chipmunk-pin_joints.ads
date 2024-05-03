with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Pin_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsPinJoint (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsPinJoint, "cpConstraintIsPinJoint");

   function cpPinJointAlloc return cpPinJoint;
   --  
   pragma Import (C, cpPinJointAlloc, "cpPinJointAlloc");

   function cpPinJointInit (joint : cpPinJoint; a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect) return cpPinJoint;
   --  
   pragma Import (C, cpPinJointInit, "cpPinJointInit");

   function cpPinJointNew (a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect) return cpConstraint;
   --  
   pragma Import (C, cpPinJointNew, "cpPinJointNew");

   function cpPinJointGetAnchorA (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, cpPinJointGetAnchorA, "cpPinJointGetAnchorA");

   procedure cpPinJointSetAnchorA (constraint : cpConstraint; anchorA : cpVect);
   --  
   pragma Import (C, cpPinJointSetAnchorA, "cpPinJointSetAnchorA");

   function cpPinJointGetAnchorB (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, cpPinJointGetAnchorB, "cpPinJointGetAnchorB");

   procedure cpPinJointSetAnchorB (constraint : cpConstraint; anchorB : cpVect);
   --  
   pragma Import (C, cpPinJointSetAnchorB, "cpPinJointSetAnchorB");

   function cpPinJointGetDist (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpPinJointGetDist, "cpPinJointGetDist");

   procedure cpPinJointSetDist (constraint : cpConstraint; dist : cpFloat);
   --  
   pragma Import (C, cpPinJointSetDist, "cpPinJointSetDist");

end Chipmunk.Pin_Joints;
