Mix.shell(Mix.Shell.Process) # Redirect Mix.shell IO to process mailbox
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

  setup do
    on_exit(&Mix.shell.flush/0) # Clear the process mailbox between tests
    on_exit(&delete_tmp_paths/0)
  end

  # ---------------------------------------------------------------------------
  # Helpers
  # ---------------------------------------------------------------------------

  def assert_file(file) do
    assert File.regular?(file), "Expected #{file} to exist, but does not"
  end

  def assert_file(file, match = %Regex{}) do
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
