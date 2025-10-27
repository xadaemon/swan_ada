package Swan.Types is

   subtype Frequency_Hz is Float;
   subtype Frequency_Sec is Float;

   function Hz_To_Sec (Frequency : Frequency_Hz) return Frequency_Sec;

   function Sec_To_Hz (Frequency : Frequency_Sec) return Frequency_Hz;

   function Sec_To_Ns (Frequency : Frequency_Sec) return Integer;

end Swan.Types;
