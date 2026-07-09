with Ada.Numerics; use Ada.Numerics;

with Ada.Numerics.Generic_Elementary_Functions;

package body Swan.Math_Util.Generic_Trig is

   package F_Funcs is new Ada.Numerics.Generic_Elementary_Functions (T_Float);

   function Vector2_Length (V : Vector2) return T_Float is
      X_Squared : constant T_Float := V.X * V.X;
      Y_Squared : constant T_Float := V.Y * V.Y;
   begin
      return F_Funcs.Sqrt (X_Squared + Y_Squared);
   end Vector2_Length;

   function Vector3_Length (V : Vector3) return T_Float is
      X_Squared : constant T_Float := V.X * V.X;
      Y_Squared : constant T_Float := V.Y * V.Y;
      Z_Squared : constant T_Float := V.Z * V.Z;
   begin
      return F_Funcs.Sqrt (X_Squared + Y_Squared + Z_Squared);
   end Vector3_Length;

   function Vector2_To_Polar (V : Vector2) return Polar_Coordinates is
      R     : constant T_Float := Vector2_Length (V);
      Theta : constant Angle_Radian := F_Funcs.Arctan (V.Y, V.X);
   begin
      return (R, Theta);
   end Vector2_To_Polar;

   function Polar_To_Vector2 (P : Polar_Coordinates) return Vector2 is
      X : constant T_Float := P.R * F_Funcs.Cos (P.Theta);
      Y : constant T_Float := P.R * F_Funcs.Sin (P.Theta);
   begin
      return (X, Y);
   end Polar_To_Vector2;

   function Vector2_Dot_Product (V1 : Vector2; V2 : Vector2) return T_Float is
   (V1.X * V2.X + V1.Y * V2.Y);

   procedure Vector2_Scale (V : Vector2_Access; S : T_Float) is
   begin
      V.X := V.X * S;
      V.Y := V.Y * S;
   end Vector2_Scale;

   procedure Vector2_Add (V1 : Vector2_Access; V2 : Vector2_Access) is
   begin
      V1.X := V1.X + V2.X;
      V1.Y := V1.Y + V2.Y;
   end Vector2_Add;

   procedure Vector2_Subtract
     (V1 : Vector2_Access; V2 : Vector2_Access) is
   begin
      V1.X := V1.X - V2.X;
      V1.Y := V1.Y - V2.Y;
   end Vector2_Subtract;

   function Vector3_To_Spherical (V : Vector3) return Spherical_Coordinates is
      R          : constant T_Float := Vector3_Length (V);
      XY_Squared : constant T_Float := V.X * V.X + V.Y * V.Y;
      Theta      : constant Angle_Radian :=
        F_Funcs.Arctan (F_Funcs.Sqrt (XY_Squared), V.Z);
      Phi        : constant Angle_Radian := F_Funcs.Arctan (V.Y, V.X);
   begin
      return (R, Theta, Phi);
   end Vector3_To_Spherical;

   function Spherical_To_Vector3 (S : Spherical_Coordinates) return Vector3 is
      Sin_Theta : constant T_Float := F_Funcs.Sin (S.Theta);
      X         : constant T_Float := S.R * Sin_Theta * F_Funcs.Cos (S.Phi);
      Y         : constant T_Float := S.R * Sin_Theta * F_Funcs.Sin (S.Phi);
      Z         : constant T_Float := S.R * F_Funcs.Cos (S.Theta);
   begin
      return (X, Y, Z);
   end Spherical_To_Vector3;

   function Deg_To_Rad (X : Angle_Degree) return Angle_Radian
   is (X * (Pi / 180.0));

   function Rad_To_Deg (X : Angle_Radian) return Angle_Degree
   is (X * (180.0 / Pi));

end Swan.Math_Util.Generic_Trig;
