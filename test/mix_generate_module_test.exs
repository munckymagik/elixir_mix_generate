defmodule Mix.Tasks.GenerateModuleTest do
  use MixGenerateTest.Case

  test "module generator: creates new module file" do
    in_tmp "test_module", fn ->
      Mix.Tasks.Generate.run ["module", "ModName"]

      assert_file "lib/mod_name.ex"
    end
  end

  test "module generator: new file contains module definition" do
    in_tmp "test_module", fn ->
      Mix.Tasks.Generate.run ["module", "ModName"]

      assert_file "lib/mod_name.ex", fn (file) ->
        assert file =~ "defmodule ModName do"
      end
    end
  end

  test "module generator: supports nested modules" do
    in_tmp "test_module", fn ->
      Mix.Tasks.Generate.run ["module", "ModParent.ModChild"]

      assert_file "lib/mod_parent/mod_child.ex", fn (file) ->
        assert file =~ "defmodule ModParent.ModChild do"
      end
    end
  end

  test "module generator: tells the user which files were created" do
    in_tmp "test_module", fn ->
      Mix.Tasks.Generate.run ["module", "ModName"]

      assert_received { :mix_shell, :info, ["* creating lib/mod_name.ex"] }
    end
  end

end
