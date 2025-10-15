generic
   type T_Float is digits <>;
package Swan_Ada.Control.PID with SPARK_Mode => On is
   type PID_Controller is limited private;
	type PID_Controller_Access is access PID_Controller;

   procedure Set_Point (Controller : in out PID_Controller; V : T_Float);

   procedure Set_Kp (Controller : in out PID_Controller; V : T_Float);

   procedure Set_Ki (Controller : in out PID_Controller; V : T_Float);

   procedure Set_Kd (Controller : in out PID_Controller; V : T_Float);

   procedure Tick
     (Controller        : in out PID_Controller;
      Process_Value, DT : T_Float;
      Pv_Out            : out T_Float);

   procedure Tick_PD
     (Controller        : in out PID_Controller;
      Process_Value, DT : T_Float;
      Pv_Out            : out T_Float);

private
   type PID_Controller is record
      Prev_Err, It, Set_Point : T_Float := 0.0;
      Kp, Kd                  : T_Float := 1.0;
      Ki                      : T_Float := 0.5;
   end record;
end Swan_Ada.Control.PID;
