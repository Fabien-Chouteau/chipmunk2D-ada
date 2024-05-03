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

   procedure cpConstraintDestroy (constraint : cpConstraint);
   --  
   pragma Import (C, cpConstraintDestroy, "cpConstraintDestroy");

   procedure cpConstraintFree (constraint : cpConstraint);
   --  
   pragma Import (C, cpConstraintFree, "cpConstraintFree");

   function cpConstraintGetSpace (constraint : cpConstraint) return cpSpace;
   --  
   pragma Import (C, cpConstraintGetSpace, "cpConstraintGetSpace");

   function cpConstraintGetBodyA (constraint : cpConstraint) return cpBody;
   --  
   pragma Import (C, cpConstraintGetBodyA, "cpConstraintGetBodyA");

   function cpConstraintGetBodyB (constraint : cpConstraint) return cpBody;
   --  
   pragma Import (C, cpConstraintGetBodyB, "cpConstraintGetBodyB");

   function cpConstraintGetMaxForce (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpConstraintGetMaxForce, "cpConstraintGetMaxForce");

   procedure cpConstraintSetMaxForce (constraint : cpConstraint; maxForce : cpFloat);
   --  
   pragma Import (C, cpConstraintSetMaxForce, "cpConstraintSetMaxForce");

   function cpConstraintGetErrorBias (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpConstraintGetErrorBias, "cpConstraintGetErrorBias");

   procedure cpConstraintSetErrorBias (constraint : cpConstraint; errorBias : cpFloat);
   --  
   pragma Import (C, cpConstraintSetErrorBias, "cpConstraintSetErrorBias");

   function cpConstraintGetMaxBias (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpConstraintGetMaxBias, "cpConstraintGetMaxBias");

   procedure cpConstraintSetMaxBias (constraint : cpConstraint; maxBias : cpFloat);
   --  
   pragma Import (C, cpConstraintSetMaxBias, "cpConstraintSetMaxBias");

   function cpConstraintGetCollideBodies (constraint : cpConstraint) return cpBool;
   --  
   pragma Import (C, cpConstraintGetCollideBodies, "cpConstraintGetCollideBodies");

   procedure cpConstraintSetCollideBodies (constraint : cpConstraint; collideBodies : cpBool);
   --  
   pragma Import (C, cpConstraintSetCollideBodies, "cpConstraintSetCollideBodies");

   function cpConstraintGetPreSolveFunc (constraint : cpConstraint) return cpConstraintPreSolveFunc;
   --  
   pragma Import (C, cpConstraintGetPreSolveFunc, "cpConstraintGetPreSolveFunc");

   procedure cpConstraintSetPreSolveFunc (constraint : cpConstraint; preSolveFunc : cpConstraintPreSolveFunc);
   --  
   pragma Import (C, cpConstraintSetPreSolveFunc, "cpConstraintSetPreSolveFunc");

   function cpConstraintGetPostSolveFunc (constraint : cpConstraint) return cpConstraintPostSolveFunc;
   --  
   pragma Import (C, cpConstraintGetPostSolveFunc, "cpConstraintGetPostSolveFunc");

   procedure cpConstraintSetPostSolveFunc (constraint : cpConstraint; postSolveFunc : cpConstraintPostSolveFunc);
   --  
   pragma Import (C, cpConstraintSetPostSolveFunc, "cpConstraintSetPostSolveFunc");

   function cpConstraintGetUserData (constraint : cpConstraint) return cpDataPointer;
   --  
   pragma Import (C, cpConstraintGetUserData, "cpConstraintGetUserData");

   procedure cpConstraintSetUserData (constraint : cpConstraint; userData : cpDataPointer);
   --  
   pragma Import (C, cpConstraintSetUserData, "cpConstraintSetUserData");

   function cpConstraintGetImpulse (constraint : cpConstraint) return cpFloat;
   --  
   pragma Import (C, cpConstraintGetImpulse, "cpConstraintGetImpulse");

end Chipmunk.Constraints;
