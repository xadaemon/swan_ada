with Ada.Unchecked_Deallocation;
with Interfaces.C; use Interfaces.C;
with Swan.Control.PID;

package Swan.Control.C_Interface is

   package PID_Inst is new PID (T_Float => double);
   use PID_Inst;

   type PID_Double is record
      Inner : PID_Inst.PID_Controller;
   end record
   with Export => True, Convention => C, External_Name => "pid_";
   type PID_Double_Access is access PID_Double;

   function Init_PID return PID_Double_Access
   with Export => True, Convention => C, External_Name => "pid_init";

   procedure Free_PID (Controller : PID_Double_Access)
   with Export => True, Convention => C, External_Name => "pid_free";

   procedure Set_Gains (Controller : PID_Double_Access; Kp, Ki, Kd : double)
   with Export => True, Convention => C, External_Name => "pid_set_gains";

   procedure Set_Point_Inner (Controller : PID_Double_Access; SP : double)
   with Export => True, Convention => C, External_Name => "pid_set_point";

   function Tick_Inner
     (Controller : PID_Double_Access; Process_Variable, DT : double)
      return double
   with Export => True, Convention => C, External_Name => "pid_tick";

private
   procedure Free is new
     Ada.Unchecked_Deallocation
       (Object => PID_Double,
        Name   => PID_Double_Access);

end Swan.Control.C_Interface;
