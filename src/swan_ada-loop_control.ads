with Swan_Ada.Frequency_Types; use Swan_Ada.Frequency_Types;

generic
   Max_Actions : Integer := 10;
   type T_DT is digits <>;
package Swan_Ada.Loop_Control is

   type Loop_Manager is limited private;
   type Loop_Manager_Access is access Loop_Manager;
   type Loop_Action is
     access procedure (DT : T_DT; Manager : Loop_Manager_Access);

   Deviated_Over_Threshold, No_Action_At_Index, Action_Index_Error : exception;

   procedure Set_Frequency
     (Manager : in out Loop_Manager; Frequency : Frequency_Hz);

   procedure Add_Action
     (Manager : in out Loop_Manager; Ordering : Integer; Action : Loop_Action);

   procedure Remove_Action (Manager : in out Loop_Manager; Ordering : Integer);

   procedure Set_Should_Stop (Manager : in out Loop_Manager; Flag : Boolean);

   procedure Run_Loop (Manager : Loop_Manager_Access);

   function Action_Count (Manager : Loop_Manager) return Positive;

private

   type Actions_List is array (0 .. Max_Actions) of Loop_Action;

   type Loop_Manager is record
      Should_Stop   : Boolean := False;
      Actions_Count : Integer := 0;
      Frequency     : Frequency_Hz := 60.0;
      Target_DeltaT : Frequency_Sec := 1.0 / 60.0;
      Actions       : Actions_List := (others => null);
   end record;

end Swan_Ada.Loop_Control;
