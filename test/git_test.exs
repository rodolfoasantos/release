defmodule GitTest do
  use ExUnit.Case

  doctest Release

  import Release.Git, only: [parse_args: 1, process: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "help returned if a empty options is given" do
    assert parse_args([]) == :help
  end

  test "A list of git hashes returned if a valid list is given" do
    assert parse_args(["9282442", "bc85ea6", "2442e2x"]) == ["9282442", "bc85ea6", "2442e2x"]
  end
end