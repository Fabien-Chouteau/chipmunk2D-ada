with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Simple_Motors
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsSimpleMotor (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintIsSimpleMotor, "cpConstraintIsSimpleMotor");

   function cpSimpleMotorAlloc return cpSimpleMotor;
   --  
   pragma Import (C, cpSimpleMotorAlloc, "cpSimpleMotorAlloc");

   function cpSimpleMotorInit (joint : cpSimpleMotor; a : cpBody; b : cpBody; rate : cpFloat) return cpSimpleMotor;
   --  
   pragma Import (C, cpSimpleMotorInit, "cpSimpleMotorInit");

   function cpSimpleMotorNew (a : cpBody; b : cpBody; rate : cpFloat) return cpConstraint;
   --  
   pragma Import (C, cpSimpleMotorNew, "cpSimpleMotorNew");

   function cpSimpleMotorGetRate (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpSimpleMotorGetRate, "cpSimpleMotorGetRate");

   procedure cpSimpleMotorSetRate (constraint : cpConstraint; rate : cpFloat);
   --  
   pragma Import (C, cpSimpleMotorSetRate, "cpSimpleMotorSetRate");

end Chipmunk.Simple_Motors;
