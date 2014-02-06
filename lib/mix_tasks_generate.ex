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
    Mix.Generator.create_file(
      module_file_path(module_name), module_template(module_name))
  end

  defp module_file_path(module_name) do
    Path.join("lib", "#{Mix.Utils.underscore(module_name)}.ex")
  end

  defp module_template(module_name) do
    """
    defmodule #{module_name} do

    end
    """
  end

end