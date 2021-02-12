defmodule SymmetricEncryptionEcto.Type.JSONTest do
  use ExUnit.Case, async: true

  alias SymmetricEncryptionEcto.Type.JSON

  test "json types" do
    map = %{"foo" => 1, "bar" => "zulu"}
    json_map = Jason.encode!(map)
    fixed_encrypted_map = SymmetricEncryption.fixed_encrypt(json_map)
    random_encrypted_map = SymmetricEncryption.encrypt(json_map)
    assert JSON.dump(map, nil, random_iv: false) == {:ok, fixed_encrypted_map}
    assert JSON.load(fixed_encrypted_map, nil, random_iv: false) == {:ok, map}
    assert JSON.load(random_encrypted_map, nil, random_iv: true) == {:ok, map}
    # Random doesn't matter for decrypting
    assert JSON.load(random_encrypted_map, nil, random_iv: false) == {:ok, map}

    assert JSON.dump(nil, nil, []) == {:ok, nil}
    assert JSON.load(nil, nil, []) == {:ok, nil}
    assert JSON.cast(nil, []) == {:ok, nil}
  end
end
