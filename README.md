# SymmetricEncryptionEcto

## Description

Provides a Custom Type for use in Ecto schemas that will encrypt values to the database.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `symmetric_encryption_ecto` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:symmetric_encryption_ecto, "~> 0.1.0"}
  ]
end
```

## Usage (Requires Ecto 3.5 or higher)

Add something similar to the following for your schema
~~~elixir
schema "foobars" do
  field(:random_field, SymmetricEncryptionEcto.Type, random_iv: true)
  # Create a fixed field if you want to query or index on it
  field(:fixed_field, SymmetricEncryptionEcto.Type, random_iv: false)
end
~~~
