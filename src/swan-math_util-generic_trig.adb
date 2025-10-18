with Ada.Numerics; use Ada.Numerics;

package body Swan.Math_Util.Generic_Trig is

   function Deg_To_Rad (X : T_Float) return T_Float
   is (X * (Pi / 180.0));
   function Rad_To_Deg (X : T_Float) return T_Float
   is (X * (180.0 / Pi));

end Swan.Math_Util.Generic_Trig;
