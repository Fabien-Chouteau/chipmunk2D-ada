package Chipmunk.Simple_Motors
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   function cpConstraintIsSimpleMotor
     (constraint : cpConstraint) return cpBool;
   --
   pragma Import (C, cpConstraintIsSimpleMotor, "cpConstraintIsSimpleMotor");

   function Alloc return cpSimpleMotor;
   --
   pragma Import (C, Alloc, "cpSimpleMotorAlloc");

   function Init
     (joint : cpSimpleMotor; a : cpBody; b : cpBody; rate : cpFloat)
      return cpSimpleMotor;
   --
   pragma Import (C, Init, "cpSimpleMotorInit");

   function NewSimpleMotor
     (a : cpBody; b : cpBody; rate : cpFloat) return cpConstraint;
   --
   pragma Import (C, NewSimpleMotor, "cpSimpleMotorNew");

   function GetRate (constraint : cpConstraint) return cpFloat;
   --
   pragma Import (C, GetRate, "cpSimpleMotorGetRate");

   procedure SetRate (constraint : cpConstraint; rate : cpFloat);
   --
   pragma Import (C, SetRate, "cpSimpleMotorSetRate");

end Chipmunk.Simple_Motors;
