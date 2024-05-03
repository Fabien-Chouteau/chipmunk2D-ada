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

   function cpDampedRotarySpringAlloc return cpDampedRotarySpring;
   --  
   pragma Import (C, cpDampedRotarySpringAlloc, "cpDampedRotarySpringAlloc");

   function cpDampedRotarySpringInit (joint : cpDampedRotarySpring; a : cpBody; b : cpBody; restAngle : cpFloat; stiffness : cpFloat; damping : cpFloat) return cpDampedRotarySpring;
   --  
   pragma Import (C, cpDampedRotarySpringInit, "cpDampedRotarySpringInit");

   function cpDampedRotarySpringNew (a : cpBody; b : cpBody; restAngle : cpFloat; stiffness : cpFloat; damping : cpFloat) return cpConstraint;
   --  
   pragma Import (C, cpDampedRotarySpringNew, "cpDampedRotarySpringNew");

   function cpDampedRotarySpringGetRestAngle (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpDampedRotarySpringGetRestAngle, "cpDampedRotarySpringGetRestAngle");

   procedure cpDampedRotarySpringSetRestAngle (constraint : cpConstraint; restAngle : cpFloat);
   --  
   pragma Import (C, cpDampedRotarySpringSetRestAngle, "cpDampedRotarySpringSetRestAngle");

   function cpDampedRotarySpringGetStiffness (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpDampedRotarySpringGetStiffness, "cpDampedRotarySpringGetStiffness");

   procedure cpDampedRotarySpringSetStiffness (constraint : cpConstraint; stiffness : cpFloat);
   --  
   pragma Import (C, cpDampedRotarySpringSetStiffness, "cpDampedRotarySpringSetStiffness");

   function cpDampedRotarySpringGetDamping (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpDampedRotarySpringGetDamping, "cpDampedRotarySpringGetDamping");

   procedure cpDampedRotarySpringSetDamping (constraint : cpConstraint; damping : cpFloat);
   --  
   pragma Import (C, cpDampedRotarySpringSetDamping, "cpDampedRotarySpringSetDamping");

   function cpDampedRotarySpringGetSpringTorqueFunc (constraint : cpConstraint) return cpDampedRotarySpringTorqueFunc;
   --  
   pragma Import (C, cpDampedRotarySpringGetSpringTorqueFunc, "cpDampedRotarySpringGetSpringTorqueFunc");

   procedure cpDampedRotarySpringSetSpringTorqueFunc (constraint : cpConstraint; springTorqueFunc : cpDampedRotarySpringTorqueFunc);
   --  
   pragma Import (C, cpDampedRotarySpringSetSpringTorqueFunc, "cpDampedRotarySpringSetSpringTorqueFunc");

end Chipmunk.Damped_Rotary_Springs;
