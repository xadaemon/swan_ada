with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics; use Ada.Numerics;
with Swan.Math_Util.Generic_Trig;

generic
   type T_Float is digits <>;
   Mean_Radius, Semi_Major, Semi_Minor, Flattening : T_Float;
package Swan.Math_Util.Generic_Nav is

   package Elementary_Functions is new
     Ada.Numerics.Generic_Elementary_Functions (T_Float);
   use Elementary_Functions;

   package Trig is new Swan.Math_Util.Generic_Trig (T_Float);
   use Trig;

   type Coordinate_Pair is record
      Lat, Lon : T_Float;
   end record;

   function Sphere_Circle_Distance (A, B : Coordinate_Pair) return T_Float;

   function Midpoint (A, B : Coordinate_Pair) return Coordinate_Pair;

end Swan.Math_Util.Generic_Nav;
