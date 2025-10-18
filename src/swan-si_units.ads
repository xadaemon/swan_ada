package Swan.SI_Units is

   type SI_Prefix is
     (Base,
      Quetta,
      Ronna,
      Yotta,
      Zetta,
      Exa,
      Peta,
      Tera,
      Giga,
      Mega,
      Kilo,
      Hecto,
      Deca,

      Quecto,
      Ronto,
      Yocto,
      Zepto,
      Atto,
      Femto,
      Pico,
      Nano,
      Micro,
      Milli,
      Centi,
      Deci);
   -- SI prefixes for conversion

   SI_Prefix_Value : constant array (SI_Prefix) of Float :=
     (Base   => 1.0,
      Quetta => 10.0e30,
      Ronna  => 10.0e27,
      Yotta  => 10.0e24,
      Zetta  => 10.0e21,
      Exa    => 10.0e18,
      Peta   => 10.0e15,
      Tera   => 10.0e12,
      Giga   => 10.0e9,
      Mega   => 10.0e6,
      Kilo   => 10.0e3,
      Hecto  => 10.0e2,
      Deca   => 10.0e1,

      Quecto => 10.0e-30,
      Ronto  => 10.0e-27,
      Yocto  => 10.0e-24,
      Zepto  => 10.0e-21,
      Atto   => 10.0e-18,
      Femto  => 10.0e-15,
      Pico   => 10.0e-12,
      Nano   => 10.0e-9,
      Micro  => 10.0e-6,
      Milli  => 10.0e-3,
      Centi  => 10.0e-2,
      Deci   => 10.0e-1);

end Swan.SI_Units;
