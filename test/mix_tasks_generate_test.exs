defmodule Mix.Tasks.GenerateTest do
  use ExUnit.Case

  # ---------------------------------------------------------------------------
  # Tests
  # ---------------------------------------------------------------------------

  test "module creates new module file" do
    in_tmp "test_module", fn ->
      Mix.Tasks.Generate.run ["module", "ModName"]
      assert_file "lib/mod_name.ex"
    end
  end

  test "new module file contains module definition" do
    in_tmp "test_module", fn ->
      Mix.Tasks.Generate.run ["module", "ModName"]
      assert_file "lib/mod_name.ex", fn (file) ->
        assert file =~ "defmodule ModName do"
      end
    end
  end

  test "supports nested modules" do
    in_tmp "test_module", fn ->
      Mix.Tasks.Generate.run ["module", "ModParent.ModChild"]
      assert_file "lib/mod_parent/mod_child.ex", fn (file) ->
        assert file =~ "defmodule ModParent.ModChild do"
      end
    end
  end

  test "tells the user which files were created" do
    in_tmp "test_module", fn ->
      Mix.Tasks.Generate.run ["module", "ModName"]

      assert_received { :mix_shell, :info, ["* creating lib/mod_name.ex"] }
    end
  end

  # ---------------------------------------------------------------------------
  # Callbacks
  # ---------------------------------------------------------------------------

  def teardown do
    # Clear the mailbox between tests
    Mix.shell.flush
  end

  # ---------------------------------------------------------------------------
  # Helpers
  # ---------------------------------------------------------------------------

  defp assert_file(file) do
    assert File.regular?(file), "Expected #{file} to exist, but does not"
  end

  defp assert_file(file, match) when is_regex(match) do
    assert_file file, &(&1 =~ match)
  end

  defp assert_file(file, callback) when is_function(callback, 1) do
    assert_file(file)
    callback.(File.read!(file))
  end

  def tmp_path do
    Path.expand("../tmp", __DIR__)
  end

  def tmp_path(extension) do
    Path.join tmp_path, extension
  end

  def in_tmp(which, function) do
    path = tmp_path(which)
    File.rm_rf! path
    File.mkdir_p! path
    File.cd! path, function
  end
end
