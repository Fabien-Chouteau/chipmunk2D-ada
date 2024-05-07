with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Pin_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsPinJoint (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsPinJoint, "cpConstraintIsPinJoint");

   function Alloc return cpPinJoint;
   --  
   pragma Import (C, Alloc, "cpPinJointAlloc");

   function Init (joint : cpPinJoint; a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect) return cpPinJoint;
   --  
   pragma Import (C, Init, "cpPinJointInit");

   function NewPinJoint (a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect) return cpConstraint;
   --  
   pragma Import (C, NewPinJoint, "cpPinJointNew");

   function GetAnchorA (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, GetAnchorA, "cpPinJointGetAnchorA");

   procedure SetAnchorA (constraint : cpConstraint; anchorA : cpVect);
   --  
   pragma Import (C, SetAnchorA, "cpPinJointSetAnchorA");

   function GetAnchorB (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, GetAnchorB, "cpPinJointGetAnchorB");

   procedure SetAnchorB (constraint : cpConstraint; anchorB : cpVect);
   --  
   pragma Import (C, SetAnchorB, "cpPinJointSetAnchorB");

   function GetDist (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetDist, "cpPinJointGetDist");

   procedure SetDist (constraint : cpConstraint; dist : cpFloat);
   --  
   pragma Import (C, SetDist, "cpPinJointSetDist");

end Chipmunk.Pin_Joints;
