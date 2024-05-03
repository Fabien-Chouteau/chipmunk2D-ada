with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Damped_Springs
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   type cpDampedSpringForceFunc is access    function  (spring : cpConstraint; dist : cpFloat) return cpFloat

     with Convention => C;

   function cpConstraintIsDampedSpring (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsDampedSpring, "cpConstraintIsDampedSpring");

   function cpDampedSpringAlloc return cpDampedSpring;
   --  
   pragma Import (C, cpDampedSpringAlloc, "cpDampedSpringAlloc");

   function cpDampedSpringInit (joint : cpDampedSpring; a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect; restLength : cpFloat; stiffness : cpFloat; damping : cpFloat) return cpDampedSpring;
   --  
   pragma Import (C, cpDampedSpringInit, "cpDampedSpringInit");

   function cpDampedSpringNew (a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect; restLength : cpFloat; stiffness : cpFloat; damping : cpFloat) return cpConstraint;
   --  
   pragma Import (C, cpDampedSpringNew, "cpDampedSpringNew");

   function cpDampedSpringGetAnchorA (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, cpDampedSpringGetAnchorA, "cpDampedSpringGetAnchorA");

   procedure cpDampedSpringSetAnchorA (constraint : cpConstraint; anchorA : cpVect);
   --  
   pragma Import (C, cpDampedSpringSetAnchorA, "cpDampedSpringSetAnchorA");

   function cpDampedSpringGetAnchorB (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, cpDampedSpringGetAnchorB, "cpDampedSpringGetAnchorB");

   procedure cpDampedSpringSetAnchorB (constraint : cpConstraint; anchorB : cpVect);
   --  
   pragma Import (C, cpDampedSpringSetAnchorB, "cpDampedSpringSetAnchorB");

   function cpDampedSpringGetRestLength (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpDampedSpringGetRestLength, "cpDampedSpringGetRestLength");

   procedure cpDampedSpringSetRestLength (constraint : cpConstraint; restLength : cpFloat);
   --  
   pragma Import (C, cpDampedSpringSetRestLength, "cpDampedSpringSetRestLength");

   function cpDampedSpringGetStiffness (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpDampedSpringGetStiffness, "cpDampedSpringGetStiffness");

   procedure cpDampedSpringSetStiffness (constraint : cpConstraint; stiffness : cpFloat);
   --  
   pragma Import (C, cpDampedSpringSetStiffness, "cpDampedSpringSetStiffness");

   function cpDampedSpringGetDamping (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpDampedSpringGetDamping, "cpDampedSpringGetDamping");

   procedure cpDampedSpringSetDamping (constraint : cpConstraint; damping : cpFloat);
   --  
   pragma Import (C, cpDampedSpringSetDamping, "cpDampedSpringSetDamping");

   function cpDampedSpringGetSpringForceFunc (constraint : cpConstraint) return cpDampedSpringForceFunc;
   --  
   pragma Import (C, cpDampedSpringGetSpringForceFunc, "cpDampedSpringGetSpringForceFunc");

   procedure cpDampedSpringSetSpringForceFunc (constraint : cpConstraint; springForceFunc : cpDampedSpringForceFunc);
   --  
   pragma Import (C, cpDampedSpringSetSpringForceFunc, "cpDampedSpringSetSpringForceFunc");

end Chipmunk.Damped_Springs;
