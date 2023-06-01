defmodule ElixirRefactoringsCatalog.Mixfile do
  use Mix.Project

  @project_description """
  Catalog of Elixir-specific Refactorings
  """

  @version "0.0.1"
  @source_url "https://github.com/lucasvegi/Elixir-Refactorings"

  def project do
    [
      app: :elixir_refactorings_catalog,
      version: @version,
      elixir: "~> 1.0",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      docs: docs(),
      description: @project_description,
      source_url: @source_url,
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end

  defp docs() do
    [
      source_ref: "v#{@version}",
      main: "readme",
      extras: [
        "README.md": [title: "README"]
      ]
    ]
  end

  defp package do
    [
      name: :elixir_refactorings_catalog,
      maintainers: ["XX", "XX"],
      licenses: ["MIT-License"],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end
end
