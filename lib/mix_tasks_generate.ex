defmodule Mix.Tasks.Generate do
  use Mix.Task

  @shortdoc "Generate boilerplate code from templates"

  @moduledoc """
  Generate boilerplate code from templates

    mix generate GENERATOR CAMELISED_NAME

  Where GENERATOR is one of:

    module   Generate a module
    modtest  Generate a module and accompanying ExUnit test
    test     Generate an ExUnit test

  And CAMELISED_NAME is a module name like MyModuleName or
  MyNameSpace.MyModuleName.
  """
  def run(["module", module_name]) do
    generate_module(module_name)
  end

  def run(["test", test_name]) do
    generate_test(test_name)
  end

  def run(["modtest", module_name]) do
    generate_module(module_name)
    generate_test("#{module_name}Test")
  end

  defp generate_module(module_name) do
    Mix.Generator.create_file(
      module_file_path(module_name), module_template(module_name))
  end

  defp generate_test(test_name) do
    Mix.Generator.create_file(
      test_file_path(test_name), test_template(test_name))
  end

  defp module_file_path(module_name) do
    Path.join("lib", "#{Mix.Utils.underscore(module_name)}.ex")
  end

  defp test_file_path(test_name) do
    Path.join("test", "#{Mix.Utils.underscore(test_name)}.exs")
  end

  defp module_template(module_name) do
    """
    defmodule #{module_name} do

    end
    """
  end

  defp test_template(test_name) do
    """
    defmodule #{test_name} do
      use ExUnit.Case

      test "the truth" do
        assert true
      end
    end
    """
  end
end