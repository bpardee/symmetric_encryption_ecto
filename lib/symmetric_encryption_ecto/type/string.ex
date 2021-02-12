defmodule SymmetricEncryptionEcto.Type.String do
  @moduledoc """
  Perform encryption for an Ecto schema field.

  Example:
    schema do
      ...
      field :password, SymmetricEncryptionEcto.Type.String, random_iv: true
      ...
    end

  Depends on [`:ecto`](https://hexdocs.pm/ecto).
  """

  use Ecto.ParameterizedType

  def type(_opts), do: :string

  def init(opts), do: opts

  def cast(value, _opts) when is_binary(value) do
    {:ok, value}
  end

  def cast(nil, _), do: {:ok, nil}
  def cast(_, _), do: :error

  def load(nil, _loader, _opts), do: {:ok, nil}

  def load(encrypted_value, _loader, _opts) do
    {:ok, SymmetricEncryption.Decryptor.decrypt(encrypted_value)}
  end

  def dump(nil, _dumper, _opts), do: {:ok, nil}

  def dump(value, _dumper, opts) do
    {:ok, SymmetricEncryption.Encryptor.encrypt(value, opts)}
  end

  def equal?(a, b, _opts) do
    a == b
  end
end
