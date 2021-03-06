defmodule Release.Mixfile do
  use Mix.Project

  def project do
    [app: :release,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :timex]]
  end

  defp deps do
    [{:timex, "~> 3.0"}]
  end
end
