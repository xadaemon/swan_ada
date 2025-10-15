generic
   type TFloat is digits <>;
package Swan_Ada.Control.PID with SPARK_Mode => On is
   type PID_Controller is limited private;

   procedure Set_Point (Controller : in out PID_Controller; V : TFloat);

   procedure Set_Kp (Controller : in out PID_Controller; V : TFloat);

   procedure Set_Ki (Controller : in out PID_Controller; V : TFloat);

   procedure Set_Kd (Controller : in out PID_Controller; V : TFloat);

   procedure Tick
     (Controller        : in out PID_Controller;
      Process_Value, DT : TFloat;
      Pv_Out            : out TFloat);

   procedure Tick_PD
     (Controller        : in out PID_Controller;
      Process_Value, DT : TFloat;
      Pv_Out            : out TFloat);

private
   type PID_Controller is record
      Prev_Err, It, Set_Point : TFloat := 0.0;
      Kp, Kd                  : TFloat := 1.0;
      Ki                      : TFloat := 0.5;
   end record;
end Swan_Ada.Control.PID;
