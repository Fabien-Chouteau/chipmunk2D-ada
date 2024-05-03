with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Slide_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsSlideJoint (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsSlideJoint, "cpConstraintIsSlideJoint");

   function cpSlideJointAlloc return cpSlideJoint;
   --  
   pragma Import (C, cpSlideJointAlloc, "cpSlideJointAlloc");

   function cpSlideJointInit (joint : cpSlideJoint; a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect; min : cpFloat; max : cpFloat) return cpSlideJoint;
   --  
   pragma Import (C, cpSlideJointInit, "cpSlideJointInit");

   function cpSlideJointNew (a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect; min : cpFloat; max : cpFloat) return cpConstraint;
   --  
   pragma Import (C, cpSlideJointNew, "cpSlideJointNew");

   function cpSlideJointGetAnchorA (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, cpSlideJointGetAnchorA, "cpSlideJointGetAnchorA");

   procedure cpSlideJointSetAnchorA (constraint : cpConstraint; anchorA : cpVect);
   --  
   pragma Import (C, cpSlideJointSetAnchorA, "cpSlideJointSetAnchorA");

   function cpSlideJointGetAnchorB (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, cpSlideJointGetAnchorB, "cpSlideJointGetAnchorB");

   procedure cpSlideJointSetAnchorB (constraint : cpConstraint; anchorB : cpVect);
   --  
   pragma Import (C, cpSlideJointSetAnchorB, "cpSlideJointSetAnchorB");

   function cpSlideJointGetMin (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpSlideJointGetMin, "cpSlideJointGetMin");

   procedure cpSlideJointSetMin (constraint : cpConstraint; min : cpFloat);
   --  
   pragma Import (C, cpSlideJointSetMin, "cpSlideJointSetMin");

   function cpSlideJointGetMax (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpSlideJointGetMax, "cpSlideJointGetMax");

   procedure cpSlideJointSetMax (constraint : cpConstraint; max : cpFloat);
   --  
   pragma Import (C, cpSlideJointSetMax, "cpSlideJointSetMax");

end Chipmunk.Slide_Joints;
