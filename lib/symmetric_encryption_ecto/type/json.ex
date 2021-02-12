defmodule SymmetricEncryptionEcto.Type.JSON do
  @moduledoc """
  Perform encryption for an Ecto schema json field.

  Example:
    schema do
      ...
      field :password, SymmetricEncryptionEcto.Type.JSON, random_iv: true
      ...
    end

  Depends on [`:ecto`](https://hexdocs.pm/ecto).
  """

  use Ecto.ParameterizedType

  def type(_opts), do: :string

  def init(opts), do: opts

  def cast(map, _opts) when is_map(map) do
    {:ok, map}
  end

  def cast(nil, _), do: {:ok, nil}
  def cast(_, _), do: :error

  def load(nil, _loader, _opts), do: {:ok, nil}

  def load(encrypted_value, _loader, _opts) do
    encrypted_value
    |> SymmetricEncryption.Decryptor.decrypt()
    |> Jason.decode()
  end

  def dump(nil, _dumper, _opts), do: {:ok, nil}

  def dump(map, _dumper, opts) when is_map(map) do
    encoded_map =
      map
      |> Jason.encode!()
      |> SymmetricEncryption.Encryptor.encrypt(opts)

    {:ok, encoded_map}
  end

  def equal?(a, b, _opts) do
    a == b
  end
end
