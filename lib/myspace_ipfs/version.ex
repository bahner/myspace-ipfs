defmodule MyspaceIpfs.Version do
  @moduledoc """
  MyspaceIpfs.Version is a collection of functions for the MyspaceIpfs library.
  """
  import MyspaceIpfs.Api
  import MyspaceIpfs.Utils

  @typep result :: MyspaceIpfs.result()

  @doc """
  Get the version of the IPFS daemon.

  ## Parameters
  What version information to return (optional). Defaults to all.
  Allowed values are: all, Commit, Golang, Version, Repo, System.

  ## Options
  https://docs.ipfs.tech/reference/kubo/rpc/#api-v0-version
  """
  @spec version(binary) :: result
  def version(name \\ "all") do
    post_query("/version")
    |> List.flatten()
    |> return_version(name)
  end

  defp return_version(versions, key) do
    if key == "all" do
      versions
      |> List.first()
      |> okify()
    else
      get_version(versions, key)
      |> okify()
    end
  end

  defp get_version(versions, key) do
    versions
    |> List.first()
    |> Map.fetch!(~c'#{key}')
  end

  @doc """
  Get the depdency versions of the IPFS daemon.
  """
  @spec deps() :: result
  def deps() do
    post_query("/version/deps")
    |> okify()
  end
end
