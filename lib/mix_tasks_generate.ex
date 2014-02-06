defmodule Mix.Tasks.Generate do
  use Mix.Task

  @shortdoc "Generate boilerplate code from templates"

  @moduledoc """
  Generate boilerplate code from templates

    mix generate ARTIFACT name

  Where ARTIFACT is one of:

    module   Generate a module
    modtest  Generate a module and accompanying ExUnit test
    test     Generate an ExUnit test
  """
  def run(["module", module_name]) do
    File.mkdir_p!("lib")
    module_path = Path.join("lib", "#{module_name}.ex")
    File.write! module_path, module_template(module_name)

  end

  defp module_template(module_name) do
    """
    defmodule #{Mix.Utils.camelize(module_name)} do

    end
    """
  end

end