package Chipmunk.Pivot_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsPivotJoint (constraint : cpConstraint) return cpBool;
   --
   pragma Import (C, cpConstraintIsPivotJoint, "cpConstraintIsPivotJoint");

   function Alloc return cpPivotJoint;
   --
   pragma Import (C, Alloc, "cpPivotJointAlloc");

   function Init
     (joint   : cpPivotJoint;
      a       : cpBody;
      b       : cpBody;
      anchorA : cpVect;
      anchorB : cpVect) return cpPivotJoint;
   --
   pragma Import (C, Init, "cpPivotJointInit");

   function NewPivotJoint
     (a : cpBody; b : cpBody; pivot : cpVect) return cpConstraint;
   --
   pragma Import (C, NewPivotJoint, "cpPivotJointNew");

   function New2PivotJoint
     (a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect)
      return cpConstraint;
   --
   pragma Import (C, New2PivotJoint, "cpPivotJointNew2");

   function GetAnchorA (constraint : cpConstraint) return cpVect;
   --
   pragma Import (C, GetAnchorA, "cpPivotJointGetAnchorA");

   procedure SetAnchorA (constraint : cpConstraint; anchorA : cpVect);
   --
   pragma Import (C, SetAnchorA, "cpPivotJointSetAnchorA");

   function GetAnchorB (constraint : cpConstraint) return cpVect;
   --
   pragma Import (C, GetAnchorB, "cpPivotJointGetAnchorB");

   procedure SetAnchorB (constraint : cpConstraint; anchorB : cpVect);
   --
   pragma Import (C, SetAnchorB, "cpPivotJointSetAnchorB");

end Chipmunk.Pivot_Joints;
