package body Swan_Ada.Control.C_Interface is
   function Init_PID return PID_Double_Access is
      PID       : constant PID_Double_Access := new PID_Double;
      PID_Inner : PID_Controller;
   begin
      PID.Inner := PID_Inner;
      return PID;
   end Init_PID;

   procedure Free_PID (Controller : PID_Double_Access) is
      Temp : PID_Double_Access := Controller;
   begin
      Free (Temp);
   end Free_PID;

   procedure Set_Gains (Controller : PID_Double_Access; Kp, Ki, Kd : double) is
   begin
      Set_Kp (Controller.Inner, Kp);
      Set_Ki (Controller.Inner, Ki);
      Set_Kd (Controller.Inner, Kd);
   end Set_Gains;

   procedure Set_Point_Inner (Controller : PID_Double_Access; SP : double) is
   begin
      Set_Point (Controller.Inner, SP);
   end Set_Point_Inner;

   function Tick_Inner
     (Controller : PID_Double_Access; Process_Variable, DT : double)
      return double
   is
      Value : double;
   begin
      Tick (Controller.Inner, Process_Variable, DT, Value);
      return Value;
   end Tick_Inner;
end Swan_Ada.Control.C_Interface;
