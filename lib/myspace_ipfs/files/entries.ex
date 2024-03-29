defmodule MyspaceIPFS.FilesEntries do
  @moduledoc false
  @enforce_keys [:entries]
  defstruct entries: []

  @spec new({:error, map}) :: {:error, map}
  def new({:error, data}) do
    {:error, data}
  end

  @spec new(map) :: MyspaceIPFS.Files.entries()
  def new(opts) when is_map(opts) do
    %__MODULE__{
      entries: gen_entries(opts)
    }
  end

  defp gen_entries(data) do
    Map.get(data, "Entries", [])
    |> Enum.map(&MyspaceIPFS.FilesEntry.new/1)
  end
end
