defmodule Mix.Tasks.GenerateNoArgs do
  use MixGenerateTest.Case

  import ExUnit.CaptureIO

  test "when called without arguments shows help" do
    assert capture_io(fn ->
      Mix.Tasks.Generate.run []
    end) =~ ~r/Generate boilerplate/
  end
end