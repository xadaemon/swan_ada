package body Swan_Ada.Math_Util.Calculus is
   function Arrange (DS, DE, DT : T_Float) return Arrangement is
      T        : T_Float := DS;
      Interval : Arrangement (0 .. Natural (DE / DT) - 1) := (others => <>);
   begin
      for K in Interval'Range loop
         Interval (K) := T;
         T := T + DT;
      end loop;

      return Interval;
   end Arrange;

   function T_Float_Array_Sum (T_Array : T_Float_Array) return T_Float is
      Sum : T_Float := 0.0;
   begin
      for N in T_Array'Range loop
         Sum := Sum + T_Array (N);
      end loop;
      return Sum;
   end T_Float_Array_Sum;

   function Approximately_Equal
     (A, B          : T_Float;
      Rel_Tolerance : T_Float := 1.0E-6;
      Abs_Tolerance : T_Float := 1.0E-6) return Boolean is
   begin
      return
        abs (A - B)
        <= T_Float'Max
             (Abs_Tolerance, Rel_Tolerance * T_Float'Max (abs A, abs B));
   end Approximately_Equal;

   function Derivative
     (Point : T_Float; Resolution : Natural := 6; Max_Approx : Natural := 2)
      return T_Float
   is
      function Average (DS, DE : T_Float) return T_Float is
      begin
         return (Get_Point (DE) - Get_Point (DS)) / (DE - DS);
      end Average;
      Tolerance   : constant T_Float := 10.0**(-Resolution);
      H           : T_Float := 1.0;
      Approx      : T_Float := Average (Point - H, Point + H);
      Next_Approx : T_Float;
   begin
      for I in 0 .. Max_Approx * Resolution loop
         H := H / 10.0;
         Next_Approx := Average (Point - H, Point + H);
         if abs (Next_Approx - Approx) < Tolerance then
            return Next_Approx;
         else
            Approx := Next_Approx;
         end if;
      end loop;
      raise Constraint_Error with "Derivative is not convergent";
   end Derivative;

   function Integral (Start, End_Point, DT : T_Float) return T_Float is
      function Short_Calc (T, DT : T_Float) return T_Float is
      begin
         return Get_Point (T) + DT;
      end Short_Calc;
      Intervals : constant Arrangement := Arrange (Start, End_Point, DT);
      Sum       : T_Float := 0.0;
   begin
      for T in Intervals'Range loop
         Sum := Sum + Short_Calc (T_Float (T), DT);
      end loop;

      return Sum;
   end Integral;
end Swan_Ada.Math_Util.Calculus;
