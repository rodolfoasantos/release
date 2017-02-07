defmodule Release.CLI do

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  def process(:help), do: Release.CLI.Help.print_basic_help

  def process(hashes) when length(hashes) > 0 do
    hashes
    |> Release.Git.process_merged_commits
  end

  def parse_args(argv) do
    case option_parser(argv) do
      { [help: true], _, _ } -> :help
      { _, [], _ } -> :help
      { _, hashes, _} -> hashes
      _ -> :help
    end
  end

  defp option_parser(argv) do
    OptionParser.parse(argv, aliases: [h: :help], switches: [help: :boolean])
  end
end
