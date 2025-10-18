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

   function Midpoint (A, B : Coordinate_Pair) return Coordinate_Pair is
      Psi_A                   : constant T_Float := Deg_To_Rad (A.Lat);
      Psi_B                   : constant T_Float := Deg_To_Rad (B.Lat);
      Lambda_A                : constant T_Float := Deg_To_Rad (A.Lon);
      Lambda_B                : constant T_Float := Deg_To_Rad (B.Lon);
      Bx, By, Psi_C, Lambda_C : T_Float;
      Return_Pair             : Coordinate_Pair;
   begin
      Bx := Cos (Psi_B) * Cos (Lambda_B - Lambda_A);
      By := Cos (Psi_B) * Sin (Lambda_B - Lambda_A);
      declare
         Int_A, Int_B : T_Float;
      begin
         Int_A := Sin (Psi_A) + Sin (Psi_B);
         Int_B := Sqrt ((Cos (Psi_A) + Bx)**2 + By**2);
         Psi_C := Arctan (Int_A, Int_B);
      end;

      Lambda_C := Lambda_A + Arctan (By, Cos (Psi_A) + Bx);
      Return_Pair.Lat := Psi_C;
      Return_Pair.Lon := Lambda_C;
      return Return_Pair;
   end Midpoint;

end Swan.Math_Util.Generic_Nav;
