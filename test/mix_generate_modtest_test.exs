defmodule Mix.Tasks.GenerateModtestTest do
  use MixGenerateTest.Case

  test "modtest generator: creates new module file and accompanying test" do
    in_tmp "modtest_generator", fn ->
      Mix.Tasks.Generate.run ["modtest", "ModName"]

      assert_file "lib/mod_name.ex", fn (file) ->
        assert file =~ "defmodule ModName do"
      end
      assert_file "test/mod_name_test.exs", fn (file) ->
        assert file =~ "defmodule ModNameTest do"
        assert file =~ "use ExUnit.Case"
      end
    end
  end

end
