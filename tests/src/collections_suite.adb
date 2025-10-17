with AUnit.Simple_Test_Cases; use AUnit.Simple_Test_Cases;
with Swan.Collections.Test;   use Swan.Collections.Test;

package body Collections_Suite is

   function Suite return Access_Test_Suite is
      Ret : constant Access_Test_Suite := new Test_Suite;
   begin
      Ret.Add_Test (Test_Case_Access'(new Swan.Collections.Test.Test));
      return Ret;
   end Suite;

end Collections_Suite;
