package body Swan_Ada.Frequency_Types is

   function Hz_To_Sec (Frequency : Frequency_Hz) return Frequency_Sec
   is (Frequency_Sec (1.0 / Frequency));
   function Sec_To_Hz (Frequency : Frequency_Sec) return Frequency_Hz
   is (Frequency_Hz (1.0 / Frequency));

end Swan_Ada.Frequency_Types;
