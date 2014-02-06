defmodule Mix.Tasks.GenerateNoArgs do
  use MixGenerateTest.Case

  test "when called without arguments shows help" do
    Mix.Tasks.Generate.run []

    assert_received { :mix_shell, :info, [<< "Generate boilerplate", _::binary >>] }
  end
end