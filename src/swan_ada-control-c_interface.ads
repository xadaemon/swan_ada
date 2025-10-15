with Interfaces.C; use Interfaces.C;
with Swan_Ada.Control.PID;

package Swan_Ada.Control.C_Interface is

   package PID_Inst is new PID (T_Float => double);
   use PID_Inst;

   type PID_Double is record
      Inner : PID_Inst.PID_Controller_Access;
   end record
   with Export => True, Convention => C, External_Name => "pid_";
   type PID_Double_Access is access PID_Double;

   function Init_PID return PID_Double_Access
   with Export => True, Convention => C, External_Name => "pid_init";

   procedure Set_Gains (Controller : PID_Double_Access; Kp, Ki, Kd : double)
   with Export => True, Convention => C, External_Name => "pid_set_gains";

   procedure Set_Point_Inner (Controller : PID_Double_Access; SP : double)
   with Export => True, Convention => C, External_Name => "pid_set_point";

   function Tick_Inner
     (Controller : PID_Double_Access; Process_Variable, DT : double)
      return double
   with Export => True, Convention => C, External_Name => "pid_tick";

end Swan_Ada.Control.C_Interface;
