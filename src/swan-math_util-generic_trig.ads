generic
   type T_Float is digits <>;
package Swan.Math_Util.Generic_Trig is

   subtype Angle_Radian is T_Float;
   subtype Angle_Degree is T_Float;

   type Vector2 is record
      X : T_Float;
      Y : T_Float;
   end record;

   type Polar_Coordinates is record
      R     : T_Float;
      Theta : Angle_Radian;
   end record;

   type Spherical_Coordinates is record
      R     : T_Float;
      Theta : Angle_Radian;
      Phi   : Angle_Radian;
   end record;

   type Vector3 is record
      X : T_Float;
      Y : T_Float;
      Z : T_Float;
   end record;

   type Vector2_Access is access all Vector2;
   type Vector3_Access is access all Vector3;

   function Vector2_Length (V : Vector2) return T_Float;
   function Vector2_To_Polar (V : Vector2) return Polar_Coordinates;
   function Vector2_Dot_Product (V1 : Vector2; V2 : Vector2) return T_Float;
   function Polar_To_Vector2 (P : Polar_Coordinates) return Vector2;
   procedure Vector2_Scale (V : Vector2_Access; S : T_Float);
   procedure Vector2_Add (V1 : Vector2_Access; V2 : Vector2_Access);
   procedure Vector2_Subtract
     (V1 : Vector2_Access; V2 : Vector2_Access);

   function Vector3_Length (V : Vector3) return T_Float;
   function Vector3_To_Spherical (V : Vector3) return Spherical_Coordinates;
   function Spherical_To_Vector3 (S : Spherical_Coordinates) return Vector3;

   function Deg_To_Rad (X : Angle_Degree) return Angle_Radian;
   function Rad_To_Deg (X : Angle_Radian) return Angle_Degree;
end Swan.Math_Util.Generic_Trig;
