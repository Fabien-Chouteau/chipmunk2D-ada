with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Pivot_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsPivotJoint (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsPivotJoint, "cpConstraintIsPivotJoint");

   function cpPivotJointAlloc return cpPivotJoint;
   --  
   pragma Import (C, cpPivotJointAlloc, "cpPivotJointAlloc");

   function cpPivotJointInit (joint : cpPivotJoint; a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect) return cpPivotJoint;
   --  
   pragma Import (C, cpPivotJointInit, "cpPivotJointInit");

   function cpPivotJointNew (a : cpBody; b : cpBody; pivot : cpVect) return cpConstraint;
   --  
   pragma Import (C, cpPivotJointNew, "cpPivotJointNew");

   function cpPivotJointNew2 (a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect) return cpConstraint;
   --  
   pragma Import (C, cpPivotJointNew2, "cpPivotJointNew2");

   function cpPivotJointGetAnchorA (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, cpPivotJointGetAnchorA, "cpPivotJointGetAnchorA");

   procedure cpPivotJointSetAnchorA (constraint : cpConstraint; anchorA : cpVect);
   --  
   pragma Import (C, cpPivotJointSetAnchorA, "cpPivotJointSetAnchorA");

   function cpPivotJointGetAnchorB (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, cpPivotJointGetAnchorB, "cpPivotJointGetAnchorB");

   procedure cpPivotJointSetAnchorB (constraint : cpConstraint; anchorB : cpVect);
   --  
   pragma Import (C, cpPivotJointSetAnchorB, "cpPivotJointSetAnchorB");

end Chipmunk.Pivot_Joints;
