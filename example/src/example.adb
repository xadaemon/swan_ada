with Ada.Text_IO; use Ada.Text_IO;
with Swan_Ada.Loop_Control;

procedure Example is
   package Loop_Ctrl is new Swan_Ada.Loop_Control (T_DT => Float);
   use Loop_Ctrl;

   procedure Print_DT (DT : Float; Unused : Loop_Manager_Access) is
   begin
      Put_Line ("DT: " & Float'Image (DT));
   end Print_DT;

   Lm : Loop_Manager_Access := new Loop_Ctrl.Loop_Manager;
begin

   Put_Line ("Starting loop");
   Loop_Ctrl.Add_Action (Lm.all, 0, Print_DT'Access);
   Loop_Ctrl.Run_Loop (Lm);
end Example;
