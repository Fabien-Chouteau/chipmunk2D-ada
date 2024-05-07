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

   function Alloc return cpDampedSpring;
   --  
   pragma Import (C, Alloc, "cpDampedSpringAlloc");

   function Init (joint : cpDampedSpring; a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect; restLength : cpFloat; stiffness : cpFloat; damping : cpFloat) return cpDampedSpring;
   --  
   pragma Import (C, Init, "cpDampedSpringInit");

   function NewDampedSpring (a : cpBody; b : cpBody; anchorA : cpVect; anchorB : cpVect; restLength : cpFloat; stiffness : cpFloat; damping : cpFloat) return cpConstraint;
   --  
   pragma Import (C, NewDampedSpring, "cpDampedSpringNew");

   function GetAnchorA (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, GetAnchorA, "cpDampedSpringGetAnchorA");

   procedure SetAnchorA (constraint : cpConstraint; anchorA : cpVect);
   --  
   pragma Import (C, SetAnchorA, "cpDampedSpringSetAnchorA");

   function GetAnchorB (constraint : cpConstraint) return cpVect;
   --  
   pragma Import (C, GetAnchorB, "cpDampedSpringGetAnchorB");

   procedure SetAnchorB (constraint : cpConstraint; anchorB : cpVect);
   --  
   pragma Import (C, SetAnchorB, "cpDampedSpringSetAnchorB");

   function GetRestLength (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetRestLength, "cpDampedSpringGetRestLength");

   procedure SetRestLength (constraint : cpConstraint; restLength : cpFloat);
   --  
   pragma Import (C, SetRestLength, "cpDampedSpringSetRestLength");

   function GetStiffness (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetStiffness, "cpDampedSpringGetStiffness");

   procedure SetStiffness (constraint : cpConstraint; stiffness : cpFloat);
   --  
   pragma Import (C, SetStiffness, "cpDampedSpringSetStiffness");

   function GetDamping (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetDamping, "cpDampedSpringGetDamping");

   procedure SetDamping (constraint : cpConstraint; damping : cpFloat);
   --  
   pragma Import (C, SetDamping, "cpDampedSpringSetDamping");

   function GetSpringForceFunc (constraint : cpConstraint) return cpDampedSpringForceFunc;
   --  
   pragma Import (C, GetSpringForceFunc, "cpDampedSpringGetSpringForceFunc");

   procedure SetSpringForceFunc (constraint : cpConstraint; springForceFunc : cpDampedSpringForceFunc);
   --  
   pragma Import (C, SetSpringForceFunc, "cpDampedSpringSetSpringForceFunc");

end Chipmunk.Damped_Springs;
