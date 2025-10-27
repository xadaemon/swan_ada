with Ada.Text_IO;              use Ada.Text_IO;
with Swan.Math_Util.Earth_Nav; use Swan.Math_Util.Earth_Nav;
with Swan.Loop_Control;

procedure Example is
   package Loop_Ctrl is new
     Swan.Loop_Control (T_DT => Float, T_User_State => Integer);
   use Loop_Ctrl;

   procedure Print_DT (Dt : Float; Manager : Loop_Manager_Access) is
   begin
      if Get_Tick_Count (Manager.all) mod 10 = 0 then
         Put_Line
           ("DT: "
            & Float'Image (Dt)
            & " Tick: "
            & Get_Tick_Count (Manager.all)'Image);
      end if;
      if Get_Tick_Count (Manager.all) > 200 then
         Set_Should_Stop (Manager.all, True);
      end if;
   end Print_DT;

   procedure Print_Bye (Dt : Float; Manager : Loop_Manager_Access) is
      Stop_State : constant Loop_Ctrl.Stop_State :=
        Get_Stop_State (Manager.all);
   begin
      if Stop_State.Should_Stop or else Stop_State.Should_Stop_Immediate then
         Put_Line ("Bye");
      end if;
   end Print_Bye;

   Lm        : Loop_Manager_Access := new Loop_Ctrl.Loop_Manager;
   A, B, Mid : Cartesian_Coordinate;
begin

   A.Lat := 35.0;
   A.Lon := 45.0;

   B.Lat := 35.0;
   B.Lon := 135.0;

   Put_Line ("Sphere distance: " & Sphere_Circle_Distance (A, B)'Image);

   Mid := Midpoint (A, B);
   Put_Line ("Midpoint is Lat: " & Mid.Lat'Image & " Lon: " & Mid.Lon'Image);

   Set_Frequency (Lm.all, 200.0);
   Add_Action (Lm.all, 0, Print_DT'Access);
   Add_Action (Lm.all, 1, Print_Bye'Access);
   Put_Line ("Starting loop");
   Run_Loop (Lm);
end Example;
