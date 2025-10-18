package body Swan.Math_Util.Generic_Nav is

   function Sphere_Circle_Distance (A, B : Coordinate_Pair) return T_Float is
      Psi_A           : constant T_Float := Deg_To_Rad (A.Lat);
      Psi_B           : constant T_Float := Deg_To_Rad (B.Lat);
      Delta_Psi       : constant T_Float := Deg_To_Rad (B.Lat - A.Lat);
      Delta_Lambda    : constant T_Float := Deg_To_Rad (B.Lon - A.Lon);
      Sq_Sin_DPsi     : constant T_Float := Sin (Delta_Psi / 2.0)**2;
      Sq_Sin_DLambda  : constant T_Float := Sin (Delta_Lambda / 2.0)**2;
      Intermediate, C : T_Float;
   begin
      Intermediate := Sq_Sin_DPsi + Cos (Psi_A) * Cos (Psi_B) * Sq_Sin_DLambda;
      C := 2.0 * Arctan (Sqrt (Intermediate), Sqrt (1.0 - Intermediate));
      return Mean_Radius * C;
   end Sphere_Circle_Distance;

   function Midpoint (A, B : Coordinate_Pair) return T_Float is
   begin
      return 1.0;
   end Midpoint;

end Swan.Math_Util.Generic_Nav;
