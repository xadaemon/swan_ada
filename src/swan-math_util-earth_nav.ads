with Swan.Math_Util.Generic_Nav;

package Swan.Math_Util.Earth_Nav is new
  Swan.Math_Util.Generic_Nav
    (T_Float     => Float,
     Mean_Radius => 6371000.0,
     Semi_Major  => 6378137.8,
     Semi_Minor  => 6356752.314140,
     Flattening  => 298.257223563);
