defmodule Release.Git do

  @message_pattern "--pretty=-date-%at-subject-%s"
  @commit_message_pattern ~r/-(?<datetime>\d*)-subject-(?<subject>\S*)/

  def process_merged_commits(hashes) do
    hashes
    |> get_commit
    |> format_commit_message
  end

  def get_commit([]), do: []
  def get_commit([head | tail]), do: [git_show(head) | get_commit(tail)]

  def git_show(hash) do
    System.cmd("git", ["show", hash, @message_pattern])
    |> elem(0)
  end

  def format_commit_message([]), do: []
  def format_commit_message([head | tail]) do
    { _, formated_commit } = parse_commit_message(head)
    [ formated_commit , format_commit_message(tail) ]
  end

  def parse_commit_message(message) do
    Regex.named_captures(@commit_message_pattern, message)
    |> Map.get_and_update!("datetime", fn value ->
        { value, format_commit_timestamp(value) }
      end)
  end

  def format_commit_timestamp(timestamp) do
    timestamp
    |> String.to_integer
    |> DateTime.from_unix!
  end
end
