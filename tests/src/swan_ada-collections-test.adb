with Ada.Text_IO;
with AUnit.Assertions;                      use AUnit.Assertions;
with Swan_Ada.Collections.Circular_Buffers;

package body Swan_Ada.Collections.Test is

   procedure Test_Circular_Buffers is
      package Circular_Buffer is new Circular_Buffers (Max => 11, T => Integer);
      use Circular_Buffer;
      type Dat_Array is array (Integer range <>) of Integer;
      Test_CB  : Circular_Buffer.Circular_Buffer;
      Data     : Dat_Array (0 .. 9) :=
        (10, 20, 30, 40, 50, 60, 70, 80, 90, 100);
      Data_Out : Dat_Array (0 .. 9) := (others => 0);
   begin
      Ada.Text_IO.Put_Line ("Item : String");
      for I in Data'Range loop
         Write_Item (Test_CB, Data (I));
      end loop;

      for I in Data_Out'Range loop
         Data_Out (I) := Read_Item (Test_CB);
      end loop;

      Assert (Data = Data_Out, "FIFO Ordering");
   end Test_Circular_Buffers;

   overriding
   function Name (T : Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Collections tests");
   end Name;

   overriding
   procedure Run_Test (T : in out Test) is
   begin
      Test_Circular_Buffers;
   end Run_Test;

end Swan_Ada.Collections.Test;
