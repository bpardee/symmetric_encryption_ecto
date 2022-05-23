defmodule SymmetricEncryptionEcto.MixProject do
  use Mix.Project

  def project do
    [
      app: :symmetric_encryption_ecto,
      version: "0.2.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :crypto]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.5"},
      {:jason, "~> 1.2"},
      {:symmetric_encryption,
       git: "https://github.com/reidmorrison/symmetric_encryption.git"}
    ]
  end
end
