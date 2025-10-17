with Ada.Strings.Unbounded;        use Ada.Strings.Unbounded;
with Swan.String_Tools.Exceptions; use Swan.String_Tools.Exceptions;

package body Swan.String_Tools is

   --  Check if the Source String starts with the Pattern
   function Starts_With (Source, Pattern : String) return Boolean is
   begin
      return
        -- Short circuit on Source smaller than Pattern
        Pattern'Length
        <= Source'Length
           -- slice the Source to the length of the pattern from the start
           -- and compare the slice to the pattern
        and then Source (Source'First .. Source'First + Pattern'Length - 1)
                 = Pattern;
   end Starts_With;

   function Ends_With (Source, Pattern : String) return Boolean is
   begin
      return
        Pattern'Length <= Source'Length
        and then Source (Source'Last - Pattern'Length + 1 .. Source'Last)
                 = Pattern;
   end Ends_With;

   function Substr
     (Source : String; Num : Natural; Dir : Substr_Dir := Left) return String
   is
      Ret_Str : Unbounded_String := To_Unbounded_String (Source'Length);
   begin
      if Num = 0 then
         return Source;
      elsif Num >= Source'Length then
         return "";
      else
         case Dir is
            when Left  =>
               Ret_Str :=
                 To_Unbounded_String
                   (Source (Source'First .. Source'First + Num - 1));

            when Right =>
               Ret_Str :=
                 To_Unbounded_String
                   (Source (Source'Last - Num + 1 .. Source'Last));
         end case;
      end if;
      return To_String (Ret_Str);

   end Substr;

   function Contains (Source, Pattern : String) return Boolean is
      Sum_Len : Natural;
   begin
      if Source'Length < Pattern'Length then
         return False;
      elsif Source'Length = Pattern'Length then
         return Source = Pattern;
      end if;
      --  Edge cases are not true, now handle the search
      for CharN in Source'Range loop
         Sum_Len := CharN + Pattern'Length - 1;
         if Source (CharN) = Pattern (Pattern'First)
           and then Sum_Len <= Source'Length
         then
            if Source (CharN .. CharN + Pattern'Length - 1) = Pattern then
               return True;
            end if;
         end if;
      end loop;
      return False;
   end Contains;

   function Index_Of (Source, Pattern : String) return Natural is
      Sum_Len : Natural;
   begin
      if Source'Length < Pattern'Length then
         raise Index_Of_Exception;
      elsif Source'Length = Pattern'Length then
         return Source'First;
      end if;
      --  Edge cases are not true, now handle the search
      for CharN in Source'Range loop
         Sum_Len := CharN + Pattern'Length - 1;
         if Source (CharN) = Pattern (Pattern'First)
           and then Sum_Len <= Source'Length
         then
            if Source (CharN .. CharN + Pattern'Length - 1) = Pattern then
               return CharN;
            end if;
         end if;
      end loop;
      raise Index_Of_Exception;
   end Index_Of;

   function Hex_To_Ada_Notation (Hex : String) return String is
   begin
      if Starts_With (Hex, "0x") then
         declare
            Temp_Hex : constant String := Hex (Hex'First + 2 .. Hex'Last);
         begin
            return "16#" & Temp_Hex & "#";
         end;
      else
         return "16#" & Hex & "#";
      end if;
   end Hex_To_Ada_Notation;

end Swan.String_Tools;
