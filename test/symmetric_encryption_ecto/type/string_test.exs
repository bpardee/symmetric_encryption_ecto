defmodule SymmetricEncryptionEcto.Type.StringTest do
  use ExUnit.Case, async: true

  alias SymmetricEncryptionEcto.Type.String

  test "string types" do
    value = "My database value"
    fixed_encrypted_value = SymmetricEncryption.fixed_encrypt(value)
    random_encrypted_value = SymmetricEncryption.encrypt(value)
    assert String.dump(value, nil, random_iv: false) == {:ok, fixed_encrypted_value}
    assert String.load(fixed_encrypted_value, nil, random_iv: false) == {:ok, value}
    assert String.load(random_encrypted_value, nil, random_iv: true) == {:ok, value}
    # Random doesn't matter for decrypting
    assert String.load(random_encrypted_value, nil, random_iv: false) == {:ok, value}

    assert String.dump(nil, nil, []) == {:ok, nil}
    assert String.load(nil, nil, []) == {:ok, nil}
    assert String.cast(nil, []) == {:ok, nil}
  end
end
