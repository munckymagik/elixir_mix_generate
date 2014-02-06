Mix.shell(Mix.Shell.Process)
ExUnit.start

defmodule MixGenerateTest.Case do
  use ExUnit.CaseTemplate

  using do
    quote do
      import MixGenerateTest.Case
    end
  end

  # ---------------------------------------------------------------------------
  # Callbacks
  # ---------------------------------------------------------------------------

  teardown do
    # Clear the mailbox between tests
    Mix.shell.flush

    delete_tmp_paths
  end

  # ---------------------------------------------------------------------------
  # Helpers
  # ---------------------------------------------------------------------------

  def assert_file(file) do
    assert File.regular?(file), "Expected #{file} to exist, but does not"
  end

  def assert_file(file, match) when is_regex(match) do
    assert_file file, &(&1 =~ match)
  end

  def assert_file(file, callback) when is_function(callback, 1) do
    assert_file(file)
    callback.(File.read!(file))
  end

  def tmp_path do
    Path.expand("../_tmp", __DIR__)
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

  defp delete_tmp_paths do
    File.rm_rf! tmp_path
  end

end
