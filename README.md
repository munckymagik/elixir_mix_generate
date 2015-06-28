# Mix Generate Task

A custom task for the [Elixir Mix tool][1], which automates generation of simple boilerplate modules and test scripts.

## Installation

Check out this repository:

```
git clone https://github.com/munckymagik/elixir_mix_generate.git
```

Run the tests:

```
cd elixir_mix_generate
mix test
```

Install (per user):

```
mix do archive.build, archive.install
```

## Usage

Within a mix project the following commands are available:

### Generate Module

Generates an empty module with the given name:

```
mix generate module MyNewModule
```

Creates ```lib/my_new_module.ex``` containing a module named ```MyNewModule```.

### Generate Test

Generates an empty test script with the given name:

```
mix generate test MyNewTest
```

Creates ```test/my_new_test.exs``` containing a new test called ```MyNewTest```.

### Generate Modtest

Generates an empty module and a corresponding test script based on the given name:

```
mix generate modtest MyNewModule
```

Creates:
* ```lib/my_new_module.ex``` containing ```MyNewModule```
* ```test/my_new_module_test.exs``` containing ```MyNewModuleTest```

## Nested Modules

All commands support creation of nested modules by using a ```.``` to separate parts of the name. E.g.

```
mix generate module MyParent.MyModule
```

... creates a module called ```lib/my_parent/my_module.ex``` containing:

```elixir
defmodule MyParent.MyModule do

end
```

  [1]: http://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html
