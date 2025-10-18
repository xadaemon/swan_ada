with Ada.Numerics.Generic_Complex_Arrays;

generic
   with package Complex_Arrays is new Ada.Numerics.Generic_Complex_Arrays (<>);
   use Complex_Arrays;
package Swan.Math_Util.FFT is

   function Fourier_Transform (Signals : Complex_Vector) return Complex_Vector;

end Swan.Math_Util.FFT;
