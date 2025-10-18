with Ada.Numerics;
with Ada.Numerics.Generic_Complex_Elementary_Functions;

package body Swan.Math_Util.Generic_FFT is

   function Fourier_Transform (Signals : Complex_Vector) return Complex_Vector
   is
      package Complex_Elementary_Functions is new
        Ada.Numerics.Generic_Complex_Elementary_Functions
          (Complex_Arrays.Complex_Types);

      use Ada.Numerics;
      use Complex_Elementary_Functions;
      use Complex_Arrays.Complex_Types;

      function FFT_Cycle
        (X : Complex_Vector; N, S : Positive) return Complex_Vector is
      begin
         if N = 1 then
            return (1 .. 1 => X (X'First));
         end if;

         declare
            Half_N : constant Positive := N / 2;
            F      : constant Complex :=
              exp (Pi * j / Real_Arrays.Real (Half_N));
            Even   : Complex_Vector := FFT_Cycle (X, Half_N, 2 * S);
            Odd    : Complex_Vector :=
              FFT_Cycle (X (X'First + S .. X'Last), Half_N, 2 * S);
         begin
            for K in 0 .. Half_N - 1 loop
               declare
                  T : constant Complex := Odd (Odd'First + K) / F**K;
               begin
                  Odd (Odd'First + K) := Even (Even'First + K) - T;
                  Even (Even'First + K) := Even (Even'First + K) + T;
               end;
            end loop;
            return Even & Odd;
         end;
      end FFT_Cycle;
   begin
      return FFT_Cycle (Signals, Signals'Last, 1);
   end Fourier_Transform;

end Swan.Math_Util.Generic_FFT;
