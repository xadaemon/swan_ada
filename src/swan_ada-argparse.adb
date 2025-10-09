with Ada.Command_Line;      use Ada.Command_Line;
with Swan_Ada.String_Tools; use Swan_Ada.String_Tools;

package body Swan_Ada.Argparse is

   procedure Init_Context (Self : in out Argument_Context) is
      Arg_C : Natural;
      Arg_V : Str_Vector.Vector;
   begin
      Arg_C := Argument_Count;
      for Arg_I in 1 .. Arg_C loop
         Arg_V.Append (To_Unbounded_String (Argument (Arg_I)));
      end loop;
      Self.Arg_V := Arg_V;
      Self.Arg_C := Arg_C;
   end Init_Context;

   procedure Add_Arg_Def
     (Self       : in out Argument_Context;
      Name       : String;
      Short_Name : Character := Character'Val (0);
      Arg_type   : Argument_Type := Bool)
   is
      Arg_Def : constant Argument_Def :=
        (Arg_Name        => To_Unbounded_String (Name),
         Arg_ShortName   => Short_Name,
         Arg_Description => To_Unbounded_String (""),
         Arg_Type        => Arg_type,
         Multi_Flags     => False);
   begin
      Self.Args_Defs.Include (To_String (Arg_Def.Arg_Name), Arg_Def);
      if Arg_Def.Arg_ShortName /= Character'Val (0) then
         Self.Args_Defs_Aliases.Include
           ("" & Arg_Def.Arg_ShortName, To_String (Arg_Def.Arg_Name));
      end if;
   end Add_Arg_Def;

   procedure Add_Multi_Flag_Arg
     (Self : in out Argument_Context; Name : String; Short_Name : Character)
   is
      Arg_Def : constant Argument_Def :=
        (Arg_Name        => To_Unbounded_String (Name),
         Arg_ShortName   => Short_Name,
         Arg_Description => To_Unbounded_String (""),
         Arg_Type        => Bool,
         Multi_Flags     => True);
   begin
      Self.Args_Defs.Include (To_String (Arg_Def.Arg_Name), Arg_Def);
      if Arg_Def.Arg_ShortName = Character'Val (0) then
         raise Constraint_Error
           with "EMultiFlagNoShort, Multiflags require a short name";
      end if;
      Self.Args_Defs_Aliases.Include
        ("" & Arg_Def.Arg_ShortName, To_String (Arg_Def.Arg_Name));

   end Add_Multi_Flag_Arg;

   function Arg_String_To_Val
     (Expected_Type : Argument_Type; Str_Value : String) return Argument_Value
   is
   begin
      case Expected_Type is
         when Str =>
            return (Str, To_Unbounded_String (Str_Value));

         when Num =>
            return (Num, Integer'Value (Str_Value));

         when Hex_Num =>
            return (Hex_Num, Natural'Value (Hex_To_Ada_Notation (Str_Value)));

         when Bool =>
            return (Bool, Boolean'Value (Str_Value));
      end case;
   end Arg_String_To_Val;

   procedure Parse_Args (Self : in out Argument_Context) is
      --  If the current arg is a value for the previous flag
      Is_Flag_Val   : Boolean := False;
      Expected_Type : Argument_Type;
      Flag_Name     : Unbounded_String;

      function Get_Flag_Type return Argument_Type is
         Flag : constant String := To_String (Flag_Name);
      begin
         if Self.Args_Defs.Contains (Flag) then
            return Self.Args_Defs (Flag).Arg_Type;
         else
            --  Unknown flag was passed in
            raise Constraint_Error
              with
                "EInvalidFlag, " & Flag & " is not registered as a valid flag";
         end if;
      end Get_Flag_Type;

      function Is_Multi_Flag return Boolean is
         Flag : constant String := To_String (Flag_Name);
      begin
         if Self.Args_Defs.Contains (Flag) then
            return Self.Args_Defs (Flag).Multi_Flags;
         else
            return False;
         end if;
      end Is_Multi_Flag;

      procedure Get_Flag_Name_From_Short (Short_Name : String) is
      begin
         if Self.Args_Defs_Aliases.Contains (Short_Name) then
            Flag_Name :=
              To_Unbounded_String (Self.Args_Defs_Aliases (Short_Name));
         else
            raise Constraint_Error
              with "EInvalidShortName " & Short_Name & " is not registered";
         end if;
      end Get_Flag_Name_From_Short;

      procedure Set_Flag_Value (Value : Argument_Value) is
         Flag : constant String := To_String (Flag_Name);
      begin
         if Self.Arg_Vals.Contains (Flag) then
            raise Constraint_Error
              with "EDuplicate, duplicate flags are not allowed";
         else
            Self.Arg_Vals.Include (Flag, Value);
         end if;
      end Set_Flag_Value;

   begin
      for Arg_I of Self.Arg_V loop
         declare
            Curr_Arg : constant String := To_String (Arg_I);
         begin
            if Starts_With (Curr_Arg, "--") then
               Flag_Name :=
                 To_Unbounded_String
                   (Curr_Arg (Curr_Arg'First + 2 .. Curr_Arg'Length));
               Expected_Type := Get_Flag_Type;
               if Expected_Type = Bool then
                  --  Special case for flags
                  Set_Flag_Value ((Bool, True));
               else
                  Is_Flag_Val := True;
               end if;
            elsif Starts_With (Curr_Arg, "-") then
               declare
                  Short_Name : constant String :=
                    (Curr_Arg (Curr_Arg'First + 1 .. Curr_Arg'First + 1));
               begin
                  Get_Flag_Name_From_Short (Short_Name);
               end;
               --  Flag_Name now should contain the resolved full name
               Expected_Type := Get_Flag_Type;
               if Curr_Arg'Length > 2 and then Is_Multi_Flag then
                  declare
                     Sub_Name   : constant String :=
                       Curr_Arg (Curr_Arg'First + 2 .. Curr_Arg'Length);
                     Multi_Name : constant String :=
                       To_String (Flag_Name) & "-" & Sub_Name;
                  begin
                     Self.Arg_Vals.Include (Multi_Name, (Bool, True));
                  end;
               elsif Expected_Type = Bool then
                  Set_Flag_Value ((Bool, True));
               else
                  Is_Flag_Val := True;
               end if;
            elsif Is_Flag_Val then
               Set_Flag_Value (Arg_String_To_Val (Expected_Type, Curr_Arg));
            else
               Self.Pos_Args.Append (Arg_I);
            end if;

         end;
      end loop;
   end Parse_Args;

   function Contains_Arg_Value
     (Self : in out Argument_Context; Arg_Name : String) return Boolean is
   begin
      if Self.Arg_Vals.Contains (Arg_Name) then
         return True;
      elsif Self.Args_Defs (Arg_Name).Arg_Type = Bool then
         return True;
      else
         return False;
      end if;
   end Contains_Arg_Value;

   function Get_Arg_Value
     (Self : Argument_Context; Arg_Name : String) return Argument_Value is
   begin
      if Self.Arg_Vals.Contains (Arg_Name) then
         return Self.Arg_Vals (Arg_Name);
      elsif Self.Args_Defs.Contains (Arg_Name)
        and then Self.Args_Defs (Arg_Name).Arg_Type = Bool
      then
         return (Bool, False);
      else
         raise Constraint_Error
           with "ENoArg, " & Arg_Name & " is not in the received args";
      end if;
   end Get_Arg_Value;

   function Get_Multi_Flag_Value
     (Self : in out Argument_Context; Arg_Name : String) return Argument_Value
   is
   begin
      begin
         return Get_Arg_Value (Self, Arg_Name);
      exception
         when Junk : Constraint_Error =>
            return (Bool, False);
      end;
   end Get_Multi_Flag_Value;

   function Has_Positional_Arg (Self : in out Argument_Context) return Boolean
   is
   begin
      return Self.Pos_Args.Is_Empty;
   end Has_Positional_Arg;

   function Pop_Positional_Arg (Self : in out Argument_Context) return String
   is
      Tmp : constant String := To_String (Self.Pos_Args.Last_Element);
   begin
      Self.Pos_Args.Delete_Last;
      return Tmp;
   end Pop_Positional_Arg;

   function Get_Positional_Arg
     (Self : in out Argument_Context; Pos : Natural) return String is
   begin
      return To_String (Self.Pos_Args.Element (Pos));
   end Get_Positional_Arg;

end Swan_Ada.Argparse;
