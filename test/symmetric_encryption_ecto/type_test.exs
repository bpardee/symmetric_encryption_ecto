defmodule SymmetricEncryptionEcto.TypeTest do
  use ExUnit.Case, async: true

  alias SymmetricEncryptionEcto.Type

  test "custom types" do
    value = "My database value"
    fixed_encrypted_value = SymmetricEncryption.fixed_encrypt(value)
    random_encrypted_value = SymmetricEncryption.encrypt(value)
    assert Type.dump(value, nil, random_iv: false) == {:ok, fixed_encrypted_value}
    assert Type.load(fixed_encrypted_value, nil, random_iv: false) == {:ok, value}
    assert Type.load(random_encrypted_value, nil, random_iv: true) == {:ok, value}
    # Random doesn't matter for decrypting
    assert Type.load(random_encrypted_value, nil, random_iv: false) == {:ok, value}

    assert Type.dump(nil, nil, []) == {:ok, nil}
    assert Type.load(nil, nil, []) == {:ok, nil}
    assert Type.cast(nil, []) == {:ok, nil}
  end
end
