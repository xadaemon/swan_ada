package body Swan_Ada.Control.PID is

   procedure Set_Point (Controller : in out PID_Controller; V : TFloat) is
   begin
      Controller.Set_Point := V;
   end Set_Point;

   procedure Set_Kp (Controller : in out PID_Controller; V : TFloat) is
   begin
      Controller.Kp := V;
   end Set_Kp;

   procedure Set_Ki (Controller : in out PID_Controller; V : TFloat) is
   begin
      Controller.Ki := V;
   end Set_Ki;

   procedure Set_Kd (Controller : in out PID_Controller; V : TFloat) is
   begin
      Controller.Kd := V;
   end Set_Kd;

   function Tick
     (Controller : in out PID_Controller; Process_Value, DT : TFloat)
      return TFloat
   is
      Error   : constant TFloat := Process_Value - Controller.Set_Point;
      P, I, D : TFloat;
   begin
      P := Controller.Kp * Error;
      I := Controller.Ki * Error * DT;
      D := Controller.Kd * (Error - Controller.Prev_Err) / DT;
      Controller.Prev_Err := Error;
      Controller.It := Controller.It + I;
      return P + Controller.It + D;
   end Tick;

   function Tick_PD
     (Controller : in out PID_Controller; Process_Value, DT : TFloat)
      return TFloat
   is
      Error   : constant TFloat := Process_Value - Controller.Set_Point;
      P, D : TFloat;
   begin
      P := Controller.Kp * Error;
      D := Controller.Kd * (Error - Controller.Prev_Err) / DT;
      Controller.Prev_Err := Error;
      return P + D;
   end Tick_PD;

end Swan_Ada.Control.PID;
