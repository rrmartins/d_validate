defmodule DValidate.MixProject do
  use Mix.Project

  def project do
    [
      app: :d_validate,
      version: "0.1.0",
      elixir: "~> 1.17",
      description: "A module for validating input fields in Elixir applications.",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, ">= 0.0.0", only: [:dev], runtime: false},
      {:credo, "~> 1.5", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Rodrigo Martins <rrmartinsjg@gmail.com>"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "https://hexdocs.pm/d_validate/changelog.html",
        "GitHub" => "https://github.com/rrmartins/d_validate"
      }
    ]
  end
end
