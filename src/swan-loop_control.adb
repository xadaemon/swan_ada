package body Swan.Loop_Control is

   procedure Set_Frequency
     (Manager : in out Loop_Manager; Frequency : Frequency_Hz) is
   begin
      Manager.Frequency := Frequency;
      Manager.Target_DeltaT := Hz_To_Sec (Frequency);
   end Set_Frequency;

   procedure Setup_Deviation_Warning
     (Manager                       : in out Loop_Manager;
      Threshold, Critical_Threshold : Time_Span;
      Callback                      : Deviation_Callback) is
   begin
      Manager.Acceptable_Deviation := Threshold;
      Manager.Critical_Threshold := Critical_Threshold;
      Manager.Deviation_Handler := Callback;
   end Setup_Deviation_Warning;

   procedure Add_Action
     (Manager : in out Loop_Manager; Ordering : Integer; Action : Loop_Action)
   is
   begin
      if Manager.Actions_Count + 1 > Max_Actions then
         raise Action_Index_Error
           with "failed to add action, max number is present";
      end if;
      Manager.Actions_Count := Manager.Actions_Count + 1;
      Manager.Actions (Ordering) := Action;
   end Add_Action;

   procedure Remove_Action (Manager : in out Loop_Manager; Ordering : Integer)
   is
   begin
      if Manager.Actions_Count = 0 then
         raise Action_Index_Error with "There is no actions to remove";
      end if;
      Manager.Actions_Count := Manager.Actions_Count - 1;
      Manager.Actions (Ordering) := null;
   end Remove_Action;

   procedure Set_Should_Stop (Manager : in out Loop_Manager; Flag : Boolean) is
   begin
      Manager.Should_Stop := Flag;
   end Set_Should_Stop;

   procedure Set_Should_Stop_Immediate
     (Manager : in out Loop_Manager; Flag : Boolean) is
   begin
      Manager.Should_stop_Immediate := Flag;
   end Set_Should_Stop_Immediate;

   procedure Set_User_State
     (Manager : in out Loop_Manager; User_State : T_User_State) is
   begin
      Manager.User_state := User_State;
   end Set_User_State;

   function Get_User_State (Manager : Loop_Manager) return T_User_State
   is (Manager.User_state);

   function Action_Count (Manager : Loop_Manager) return Positive
   is (Manager.Actions_Count);

   function Get_Tick_Count (Manager : Loop_Manager) return Tick_Count
   is (Manager.Tick);

   function Get_Frequency (Manager : Loop_Manager) return Frequency_Hz
   is (Manager.Frequency);

   function Get_Stop_State (Manager : Loop_Manager) return Stop_State is
      State : Stop_State;
   begin
      State.Should_Stop := Manager.Should_Stop;
      State.Should_Stop_Immediate := Manager.Should_stop_Immediate;
      return State;
   end Get_Stop_State;

   procedure Run_Loop (Manager : Loop_Manager_Access) is
      Start_Time, End_Time : Time;
      Dt                   : Time_Span;
      Dt_Duration          : Duration;
      Action               : Loop_Action;
      Target_Span          : constant Time_Span :=
        Nanoseconds (Sec_To_Ns (Manager.Target_DeltaT));
   begin
      Start_Time := Clock;

      if not (Manager.Actions_Count > 0) then
         raise Constraint_Error
           with "No actions registered in the loop manager";
      end if;

      Outer_Loop :
      loop
         End_Time := Clock;
         Dt := End_Time - Start_Time;
         Dt_Duration := To_Duration (Dt);
         exit Outer_Loop when Manager.Should_Stop;

         if Dt > Manager.Critical_Threshold then
            raise Deviated_Over_Critical_Threshold
              with
                "Delta "
                & Dt_Duration'Image
                & " is over the allowable "
                & To_Duration (Manager.Critical_Threshold)'Image;
         elsif Dt > Manager.Acceptable_Deviation
           and then Manager.Deviation_Handler /= null
         then
            Manager.Deviation_Handler (T_Dt (Dt_Duration), Manager);
         end if;

         if Dt < Target_Span then
            goto Skip_Cycle;
         end if;

         for I in Manager.Actions'Range loop
            exit Outer_Loop when Manager.Should_stop_Immediate;

            Action := Manager.Actions (I);
            if Action /= null then
               Action (T_Dt (Dt_Duration), Manager);
            end if;
         end loop;

         Manager.Tick := Manager.Tick + 1;

         Start_Time := Clock;
         <<Skip_Cycle>>
      end loop Outer_Loop;

   end Run_Loop;

end Swan.Loop_Control;
