package Swan_Ada.Math_Util is

   generic
      type T_Float is digits <>;
   package Calculus is
      type Arrangement is array (Natural range <>) of T_Float;
      type T_Float_Array is array (Natural range <>) of T_Float;

      function Arrange (DS, DE, DT : T_Float) return Arrangement;

      function T_Float_Array_Sum (T_Array : T_Float_Array) return T_Float;

      function Approximately_Equal
        (A, B          : T_Float;
         Rel_Tolerance : T_Float := 1.0E-6;
         Abs_Tolerance : T_Float := 1.0E-6) return Boolean;

      generic
         with function Get_Point (T : T_Float) return T_Float;
      function Derivative
        (Point : T_Float; Resolution : Natural := 6; Max_Approx : Natural := 2)
         return T_Float;

      generic
         with function Get_Point (T : T_Float) return T_Float;
      function Integral (Start, End_Point, DT : T_Float) return T_Float;
   end Calculus;

end Swan_Ada.Math_Util;
