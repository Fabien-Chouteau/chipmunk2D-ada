with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Rotary_Limit_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsRotaryLimitJoint (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsRotaryLimitJoint, "cpConstraintIsRotaryLimitJoint");

   function cpRotaryLimitJointAlloc return cpRotaryLimitJoint;
   --  
   pragma Import (C, cpRotaryLimitJointAlloc, "cpRotaryLimitJointAlloc");

   function cpRotaryLimitJointInit (joint : cpRotaryLimitJoint; a : cpBody; b : cpBody; min : cpFloat; max : cpFloat) return cpRotaryLimitJoint;
   --  
   pragma Import (C, cpRotaryLimitJointInit, "cpRotaryLimitJointInit");

   function cpRotaryLimitJointNew (a : cpBody; b : cpBody; min : cpFloat; max : cpFloat) return cpConstraint;
   --  
   pragma Import (C, cpRotaryLimitJointNew, "cpRotaryLimitJointNew");

   function cpRotaryLimitJointGetMin (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpRotaryLimitJointGetMin, "cpRotaryLimitJointGetMin");

   procedure cpRotaryLimitJointSetMin (constraint : cpConstraint; min : cpFloat);
   --  
   pragma Import (C, cpRotaryLimitJointSetMin, "cpRotaryLimitJointSetMin");

   function cpRotaryLimitJointGetMax (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpRotaryLimitJointGetMax, "cpRotaryLimitJointGetMax");

   procedure cpRotaryLimitJointSetMax (constraint : cpConstraint; max : cpFloat);
   --  
   pragma Import (C, cpRotaryLimitJointSetMax, "cpRotaryLimitJointSetMax");

end Chipmunk.Rotary_Limit_Joints;
