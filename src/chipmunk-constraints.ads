with Interfaces.C;
with Interfaces.C.Strings;
package Chipmunk.Constraints
  with Preelaborate
is
   pragma Style_Checks ("M2000");
   type cpConstraintPreSolveFunc is access    procedure  (constraint : cpConstraint; space : cpSpace)

     with Convention => C;

   type cpConstraintPostSolveFunc is access    procedure  (constraint : cpConstraint; space : cpSpace)

     with Convention => C;

   procedure Destroy (constraint : cpConstraint);
   --  
   pragma Import (C, Destroy, "cpConstraintDestroy");

   procedure Free (constraint : cpConstraint);
   --  
   pragma Import (C, Free, "cpConstraintFree");

   function GetSpace (constraint : cpConstraint) return cpSpace;
   --  
   pragma Import (C, GetSpace, "cpConstraintGetSpace");

   function GetBodyA (constraint : cpConstraint) return cpBody;
   --  
   pragma Import (C, GetBodyA, "cpConstraintGetBodyA");

   function GetBodyB (constraint : cpConstraint) return cpBody;
   --  
   pragma Import (C, GetBodyB, "cpConstraintGetBodyB");

   function GetMaxForce (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetMaxForce, "cpConstraintGetMaxForce");

   procedure SetMaxForce (constraint : cpConstraint; maxForce : cpFloat);
   --  
   pragma Import (C, SetMaxForce, "cpConstraintSetMaxForce");

   function GetErrorBias (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetErrorBias, "cpConstraintGetErrorBias");

   procedure SetErrorBias (constraint : cpConstraint; errorBias : cpFloat);
   --  
   pragma Import (C, SetErrorBias, "cpConstraintSetErrorBias");

   function GetMaxBias (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetMaxBias, "cpConstraintGetMaxBias");

   procedure SetMaxBias (constraint : cpConstraint; maxBias : cpFloat);
   --  
   pragma Import (C, SetMaxBias, "cpConstraintSetMaxBias");

   function GetCollideBodies (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, GetCollideBodies, "cpConstraintGetCollideBodies");

   procedure SetCollideBodies (constraint : cpConstraint; collideBodies : cpBool);
   --  
   pragma Import (C, SetCollideBodies, "cpConstraintSetCollideBodies");

   function GetPreSolveFunc (constraint : cpConstraint) return cpConstraintPreSolveFunc;
   --  
   pragma Import (C, GetPreSolveFunc, "cpConstraintGetPreSolveFunc");

   procedure SetPreSolveFunc (constraint : cpConstraint; preSolveFunc : cpConstraintPreSolveFunc);
   --  
   pragma Import (C, SetPreSolveFunc, "cpConstraintSetPreSolveFunc");

   function GetPostSolveFunc (constraint : cpConstraint) return cpConstraintPostSolveFunc;
   --  
   pragma Import (C, GetPostSolveFunc, "cpConstraintGetPostSolveFunc");

   procedure SetPostSolveFunc (constraint : cpConstraint; postSolveFunc : cpConstraintPostSolveFunc);
   --  
   pragma Import (C, SetPostSolveFunc, "cpConstraintSetPostSolveFunc");

   function GetUserData (constraint : cpConstraint) return cpDataPointer;
   --  
   pragma Import (C, GetUserData, "cpConstraintGetUserData");

   procedure SetUserData (constraint : cpConstraint; userData : cpDataPointer);
   --  
   pragma Import (C, SetUserData, "cpConstraintSetUserData");

   function GetImpulse (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, GetImpulse, "cpConstraintGetImpulse");

end Chipmunk.Constraints;
