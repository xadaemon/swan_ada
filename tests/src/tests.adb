with AUnit.Reporter.Text;
with AUnit.Run;
with String_Suite;
with Math_Suite;
with Collections_Suite;

procedure Tests is
   procedure String_Suite_Runner is new
     AUnit.Run.Test_Runner (String_Suite.Suite);
   procedure Math_Suite_Runner is new AUnit.Run.Test_Runner (Math_Suite.Suite);
   procedure Collections_Suite_Runner is new
     AUnit.Run.Test_Runner (Collections_Suite.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   String_Suite_Runner (Reporter);
   Math_Suite_Runner (Reporter);
   Collections_Suite_Runner (Reporter);
end Tests;
