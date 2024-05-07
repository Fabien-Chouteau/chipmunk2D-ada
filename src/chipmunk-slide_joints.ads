with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Slide_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsSlideJoint (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsSlideJoint, "cpConstraintIsSlideJoint");

   function Alloc return cpSlideJoint;
   --  
   pragma Import (C, Alloc, "cpSlideJointAlloc");

   function Init (joint : cpSlideJoint; a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect; min : cpFloat; max : cpFloat) return cpSlideJoint;
   --  
   pragma Import (C, Init, "cpSlideJointInit");

   function NewSlideJoint (a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect; min : cpFloat; max : cpFloat) return cpConstraint;
   --  
   pragma Import (C, NewSlideJoint, "cpSlideJointNew");

   function GetAnchorA (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, GetAnchorA, "cpSlideJointGetAnchorA");

   procedure SetAnchorA (constraint : cpConstraint; anchorA : cpVect);
   --  
   pragma Import (C, SetAnchorA, "cpSlideJointSetAnchorA");

   function GetAnchorB (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, GetAnchorB, "cpSlideJointGetAnchorB");

   procedure SetAnchorB (constraint : cpConstraint; anchorB : cpVect);
   --  
   pragma Import (C, SetAnchorB, "cpSlideJointSetAnchorB");

   function GetMin (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetMin, "cpSlideJointGetMin");

   procedure SetMin (constraint : cpConstraint; min : cpFloat);
   --  
   pragma Import (C, SetMin, "cpSlideJointSetMin");

   function GetMax (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetMax, "cpSlideJointGetMax");

   procedure SetMax (constraint : cpConstraint; max : cpFloat);
   --  
   pragma Import (C, SetMax, "cpSlideJointSetMax");

end Chipmunk.Slide_Joints;
