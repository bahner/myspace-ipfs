defmodule MyspaceIPFS.Api.Advanced.Filestore do
  @moduledoc """
  MyspaceIPFS.Api is where the filestore commands of the IPFS API reside.
  """
  import MyspaceIPFS.Utils

  @doc """
  List blocks that are both in the filestore and standard block storage.
  """
  @spec dups :: {:client_error | :forbidden | :missing | :not_allowed | :ok | :server_error, any}
  def dups, do: request_get("/filestore/dups")

  @doc """
  List objects in the filestore.
  """
  @spec ls :: {:client_error | :forbidden | :missing | :not_allowed | :ok | :server_error, any}
  def ls, do: request_get("/filestore/ls")

  @doc """
  verify that objects in the filestore are not corrupted.
  """
  @spec verify ::
          {:client_error | :forbidden | :missing | :not_allowed | :ok | :server_error, any}
  def verify, do: request_get("/filestore/verify")
end
