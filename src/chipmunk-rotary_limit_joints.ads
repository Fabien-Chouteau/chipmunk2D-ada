with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Rotary_Limit_Joints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsRotaryLimitJoint (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsRotaryLimitJoint, "cpConstraintIsRotaryLimitJoint");

   function Alloc return cpRotaryLimitJoint;
   --  
   pragma Import (C, Alloc, "cpRotaryLimitJointAlloc");

   function Init (joint : cpRotaryLimitJoint; a : cpBody; b : cpBody; min : cpFloat; max : cpFloat) return cpRotaryLimitJoint;
   --  
   pragma Import (C, Init, "cpRotaryLimitJointInit");

   function NewRotaryLimitJoint (a : cpBody; b : cpBody; min : cpFloat; max : cpFloat) return cpConstraint;
   --  
   pragma Import (C, NewRotaryLimitJoint, "cpRotaryLimitJointNew");

   function GetMin (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetMin, "cpRotaryLimitJointGetMin");

   procedure SetMin (constraint : cpConstraint; min : cpFloat);
   --  
   pragma Import (C, SetMin, "cpRotaryLimitJointSetMin");

   function GetMax (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetMax, "cpRotaryLimitJointGetMax");

   procedure SetMax (constraint : cpConstraint; max : cpFloat);
   --  
   pragma Import (C, SetMax, "cpRotaryLimitJointSetMax");

end Chipmunk.Rotary_Limit_Joints;
