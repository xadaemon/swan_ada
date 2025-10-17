with AUnit.Simple_Test_Cases; use AUnit.Simple_Test_Cases;
with Swan.Math_Util.Test;     use Swan.Math_Util.Test;

package body Math_Suite is

   function Suite return Access_Test_Suite is
      Ret : constant Access_Test_Suite := new Test_Suite;
   begin
      Ret.Add_Test (Test_Case_Access'(new Swan.Math_Util.Test.Test));
      return Ret;
   end Suite;

end Math_Suite;
