package Swan_Ada.Frequency_Types is

   type Frequency_Hz is new Float;
   type Frequency_Sec is new Float;

   function Hz_To_Sec (Frequency : Frequency_Hz) return Frequency_Sec;
   function Sec_To_Hz (Frequency : Frequency_Sec) return Frequency_Hz;

end Swan_Ada.Frequency_Types;
