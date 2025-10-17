with AUnit.Simple_Test_Cases; use AUnit.Simple_Test_Cases;
with Swan.String_Tools.Test;  use Swan.String_Tools.Test;

package body String_Suite is

   function Suite return Access_Test_Suite is
      Ret : constant Access_Test_Suite := new Test_Suite;
   begin
      Ret.Add_Test (Test_Case_Access'(new Swan.String_Tools.Test.Test));
      return Ret;
   end Suite;

end String_Suite;
