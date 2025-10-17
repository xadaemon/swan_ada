with Ada.Containers.Vectors;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Hash;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Swan.Arg_Parser is
   type Argument_Type is (Str, Num, Bool, Hex_Num);

   type Argument_Def is record
      Arg_Name        : Unbounded_String;
      --  Full name for the argument i.e --output
      Arg_ShortName   : Character := Character'Val (0);
      --  Short name i.e -o
      Arg_Description : Unbounded_String;
      --  Description for help generation (not implemented yet)
      Arg_Type        : Argument_Type;
      --  Type for the argument, can be Str, Num, Bool, Hex_Num
      Multi_Flags     : Boolean;
      --  Compact form will allow arguments in the form of
      --  -Wall or -ffreestanding, it will save the argument as
      --  ffreestanding and the only supported type for this form
      --  Bool
   end record;

   package Arg_Def_HM is new
     Ada.Containers.Indefinite_Hashed_Maps
       (Key_Type        => String,
        Element_Type    => Argument_Def,
        Hash            => Ada.Strings.Hash,
        Equivalent_Keys => "=");

   package Arg_Def_Alias_Map is new
     Ada.Containers.Indefinite_Hashed_Maps
       (Key_Type        => String,
        Element_Type    => String,
        Hash            => Ada.Strings.Hash,
        Equivalent_Keys => "=");

   package Str_Vector is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Unbounded_String);

   type Argument_Value (Val_Type : Argument_Type) is record
      case Val_Type is
         when Str =>
            Val_Str : Unbounded_String;

         when Num =>
            Val_Int : Integer;

         when Hex_Num =>
            Val_Nat : Natural;

         when Bool =>
            Val_Bool : Boolean;
      end case;
   end record;

   package Arg_Val_HM is new
     Ada.Containers.Indefinite_Hashed_Maps
       (Key_Type        => String,
        Element_Type    => Argument_Value,
        Hash            => Ada.Strings.Hash,
        Equivalent_Keys => "=");

   type Argument_Context is tagged record
      Args_Defs         : Arg_Def_HM.Map;
      Args_Defs_Aliases : Arg_Def_Alias_Map.Map;
      Arg_V             : Str_Vector.Vector;
      Arg_C             : Natural;
      Arg_Vals          : Arg_Val_HM.Map;
      Pos_Args          : Str_Vector.Vector;
   end record;

   procedure Init_Context (Self : in out Argument_Context);

   procedure Add_Arg_Def
     (Self       : in out Argument_Context;
      Name       : String;
      Short_Name : Character := Character'Val (0);
      Arg_type   : Argument_Type := Bool);

   procedure Add_Multi_Flag_Arg
     (Self : in out Argument_Context; Name : String; Short_Name : Character);

   procedure Parse_Args (Self : in out Argument_Context);

   function Get_Arg_Value
     (Self : Argument_Context; Arg_Name : String) return Argument_Value;

   function Get_Multi_Flag_Value
     (Self : in out Argument_Context; Arg_Name : String) return Argument_Value;

   function Contains_Arg_Value
     (Self : in out Argument_Context; Arg_Name : String) return Boolean;

   function Has_Positional_Arg (Self : in out Argument_Context) return Boolean;

   function Pop_Positional_Arg (Self : in out Argument_Context) return String;

   function Get_Positional_Arg
     (Self : in out Argument_Context; Pos : Natural) return String;

end Swan.Arg_Parser;
