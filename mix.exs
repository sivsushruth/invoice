defmodule Invoice.Mixfile do
  use Mix.Project

  def project do
    [
      app: :invoice,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      name: "Invoice",
      source_url: "https://github.com/sivsushruth/Invoice",
      homepage_url: "https://github.com/sivsushruth/Invoice",
      docs: [
        main: "Invoice",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp description() do
    "Invoice generation and manipulation written in pure elixir"
  end

  defp package() do
    [
      name: "invoice",
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/sivsushruth/invoice", "Documentation" => "https://hexdocs.pm/invoice"}
    ]
  end

  defp deps do
    [
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.15.0", only: :dev, runtime: false},
    ]
  end
end
