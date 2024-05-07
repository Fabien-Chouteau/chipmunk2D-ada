with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Damped_Rotary_Springs
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   type cpDampedRotarySpringTorqueFunc is access    function  (spring : cpConstraint; relativeAngle : cpFloat) return cpFloat

     with Convention => C;

   function cpConstraintIsDampedRotarySpring (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsDampedRotarySpring, "cpConstraintIsDampedRotarySpring");

   function Alloc return cpDampedRotarySpring;
   --  
   pragma Import (C, Alloc, "cpDampedRotarySpringAlloc");

   function Init (joint : cpDampedRotarySpring; a : cpBody; b : cpBody; restAngle : cpFloat; stiffness : cpFloat; damping : cpFloat) return cpDampedRotarySpring;
   --  
   pragma Import (C, Init, "cpDampedRotarySpringInit");

   function NewDampedRotarySpring (a : cpBody; b : cpBody; restAngle : cpFloat; stiffness : cpFloat; damping : cpFloat) return cpConstraint;
   --  
   pragma Import (C, NewDampedRotarySpring, "cpDampedRotarySpringNew");

   function GetRestAngle (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetRestAngle, "cpDampedRotarySpringGetRestAngle");

   procedure SetRestAngle (constraint : cpConstraint; restAngle : cpFloat);
   --  
   pragma Import (C, SetRestAngle, "cpDampedRotarySpringSetRestAngle");

   function GetStiffness (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetStiffness, "cpDampedRotarySpringGetStiffness");

   procedure SetStiffness (constraint : cpConstraint; stiffness : cpFloat);
   --  
   pragma Import (C, SetStiffness, "cpDampedRotarySpringSetStiffness");

   function GetDamping (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetDamping, "cpDampedRotarySpringGetDamping");

   procedure SetDamping (constraint : cpConstraint; damping : cpFloat);
   --  
   pragma Import (C, SetDamping, "cpDampedRotarySpringSetDamping");

   function GetSpringTorqueFunc (constraint : cpConstraint) return cpDampedRotarySpringTorqueFunc;
   --  
   pragma Import (C, GetSpringTorqueFunc, "cpDampedRotarySpringGetSpringTorqueFunc");

   procedure SetSpringTorqueFunc (constraint : cpConstraint; springTorqueFunc : cpDampedRotarySpringTorqueFunc);
   --  
   pragma Import (C, SetSpringTorqueFunc, "cpDampedRotarySpringSetSpringTorqueFunc");

end Chipmunk.Damped_Rotary_Springs;
