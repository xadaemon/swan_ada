with Ada.Real_Time; use Ada.Real_Time;
with Swan.Types;    use Swan.Types;

generic
   Max_Actions : Integer := 10;
   type T_Dt is digits <>;
   type T_User_State is private;
package Swan.Loop_Control is

   type Loop_Manager is limited private;
   type Loop_Manager_Access is access Loop_Manager;
   type Loop_Action is
     access procedure (DT : T_Dt; Manager : Loop_Manager_Access);
   type Deviation_Callback is
     access procedure (Deviation : T_Dt; Manager : Loop_Manager_Access);

   type Tick_Count is mod 2**64;

   type Stop_State is record
      Should_Stop, Should_Stop_Immediate : Boolean;
   end record;

   Deviated_Over_Critical_Threshold       : exception;
   No_Action_At_Index, Action_Index_Error : exception;

   procedure Set_Frequency
     (Manager : in out Loop_Manager; Frequency : Frequency_Hz);

   procedure Setup_Deviation_Warning
     (Manager                       : in out Loop_Manager;
      Threshold, Critical_Threshold : Time_Span;
      Callback                      : Deviation_Callback);

   procedure Add_Action
     (Manager : in out Loop_Manager; Ordering : Integer; Action : Loop_Action);

   procedure Remove_Action (Manager : in out Loop_Manager; Ordering : Integer);

   procedure Set_Should_Stop (Manager : in out Loop_Manager; Flag : Boolean);

   procedure Set_Should_Stop_Immediate
     (Manager : in out Loop_Manager; Flag : Boolean);

   procedure Set_User_State
     (Manager : in out Loop_Manager; User_State : T_User_State);

   procedure Run_Loop (Manager : Loop_Manager_Access);

   function Action_Count (Manager : Loop_Manager) return Positive;

   function Get_Tick_Count (Manager : Loop_Manager) return Tick_Count;

   function Get_Stop_State (Manager : Loop_Manager) return Stop_State;

   function Get_User_State (Manager : Loop_Manager) return T_User_State;

   function Get_Frequency (Manager : Loop_Manager) return Frequency_Hz;

private

   type Actions_List is array (0 .. Max_Actions) of Loop_Action;

   type Loop_Manager is tagged record
      Should_Stop, Should_stop_Immediate : Boolean := False;

      Tick                 : Tick_Count := 0;
      Actions_Count        : Integer := 0;
      Frequency            : Frequency_Hz := 60.0;
      Target_DeltaT        : Frequency_Sec := 1.0 / 60.0;
      Actions              : Actions_List := (others => null);
      User_state           : T_User_State;
      Acceptable_Deviation : Time_Span := Time_Span_Last;
      Critical_Threshold   : Time_Span := Time_Span_Last;

      Deviation_Handler : Deviation_Callback;
   end record;

end Swan.Loop_Control;
