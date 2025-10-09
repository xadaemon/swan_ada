package body Swan_Ada.Collections.Circular_Buffers is

   procedure Write_Item (CB : in out Circular_Buffer; Item : T) is
      Next_Index : constant Integer := (CB.WriteI + 1) mod Max;
   begin
      if not Allow_Overwrite and then Next_Index = CB.ReadI then
         raise Would_Overwrite;
      end if;

      CB.Container (CB.WriteI) := Item;
      CB.WriteI := Next_Index;
   end Write_Item;

   function Read_Item (CB : in out Circular_Buffer) return T is
      Next_Index : constant Integer := (CB.ReadI + 1) mod Max;
      T_Ret      : T;
   begin
      if CB.WriteI = CB.ReadI then
         raise Is_Empty;
      end if;

      T_Ret := CB.Container (CB.ReadI);
      CB.ReadI := Next_Index;
      return T_Ret;
   end Read_Item;

   function Read_Item_Unchecked (CB : in out Circular_Buffer) return T is
      Next_Index : constant Integer := (CB.ReadI + 1) mod Max;
      T_Ret      : T;
   begin
      T_Ret := CB.Container (CB.ReadI);
      CB.ReadI := Next_Index;
      return T_Ret;
   end Read_Item_Unchecked;

   function Check_Is_Empty (CB : Circular_Buffer) return Boolean is
   begin
      return CB.ReadI = CB.WriteI;
   end Check_Is_Empty;

end Swan_Ada.Collections.Circular_Buffers;
