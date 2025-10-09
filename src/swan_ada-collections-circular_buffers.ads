generic
   Max : Positive;
   Allow_Overwrite : Boolean := False;
   type T is private;
package Swan_Ada.Collections.Circular_Buffers is

   type Circular_Buffer is limited private;

   Would_Overwrite, Is_Empty : exception;

   procedure Write_Item (CB : in out Circular_Buffer; Item : T);

   function Read_Item (CB : in out Circular_Buffer) return T;

private
   type CB_Array is array (Natural range <>) of T;

   Min : constant := 0;

   type Circular_Buffer is record
      Container     : CB_Array (Min .. Max);
      ReadI, WriteI : Integer := Min;
   end record;

end Swan_Ada.Collections.Circular_Buffers;
---  Circular buffer, with the option to deny overwriting writes,
---  such writes are denied in case Allow_Overwrite is False
