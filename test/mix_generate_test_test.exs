defmodule Mix.Tasks.GenerateTestTest do
  use MixGenerateTest.Case

  test "test generator: creates new test file" do
    in_tmp "test_test", fn ->
      Mix.Tasks.Generate.run ["test", "TestName"]

      assert_file "test/test_name.exs"
    end
  end

  test "test generator: new file contains test definition" do
    in_tmp "test_test", fn ->
      Mix.Tasks.Generate.run ["test", "TestName"]

      assert_file "test/test_name.exs", fn (file) ->
        assert file =~ "defmodule TestName do"
        assert file =~ "use ExUnit.Case"
      end
    end
  end

  test "test generator: supports nested modules" do
    in_tmp "test_test", fn ->
      Mix.Tasks.Generate.run ["test", "TestParent.TestChild"]

      assert_file "test/test_parent/test_child.exs", fn (file) ->
        assert file =~ "defmodule TestParent.TestChild do"
      end
    end
  end

  test "test generator: tells the user which files were created" do
    in_tmp "test_test", fn ->
      Mix.Tasks.Generate.run ["test", "TestName"]

      assert_received { :mix_shell, :info, ["* creating test/test_name.exs"] }
    end
  end

end
