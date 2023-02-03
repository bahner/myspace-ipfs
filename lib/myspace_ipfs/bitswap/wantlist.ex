defmodule MyspaceIPFS.BitswapWantList do
  @moduledoc """
  A struct that represents the wantlist for a peer in the bitswap network.
  """

  import MyspaceIPFS.Utils
  defstruct keys: []

  @type t :: %__MODULE__{
          keys: list | nil
        }

  @doc """
  Generate a new BitswapWantList struct or passthrough an error message
  from the IPFS API
  """
  @spec new({:error, map}) :: {:error, map}
  def new({:error, data}) do
    {:error, data}
  end

  @spec new(map) :: MyspaceIPFS.BitswapWantList.t()
  def new(opts) do
    opts = snake_atomize(opts)

    %__MODULE__{
      keys: opts.keys
    }
  end
end
