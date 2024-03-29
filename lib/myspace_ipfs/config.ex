defmodule MyspaceIPFS.Config do
  @moduledoc """
  MyspaceIPFS.Config is where the config commands of the IPFS API reside.
  """
  import MyspaceIPFS.Api
  import MyspaceIPFS.Utils

  @doc """
  Get the value of a config key.

  ## Parameters
  key: The key to get the value of.
  """
  @spec get(binary()) :: {:ok, any} | MyspaceIPFS.Api.error_response()
  def get(key) do
    post_query("/config?arg=" <> key)
    |> okify()
  end

  @doc """
  Get the entire config.
  """
  @spec get() :: {:ok, any} | MyspaceIPFS.Api.error_response()
  def get() do
    post_query("/config")
    |> okify()
  end

  @doc """
  Set the value of a config key. This command accepts a JSON object  or a boolean as the value.

  JSON objects must be passed as a string.
  """
  @spec set(binary, binary) :: {:ok, any} | MyspaceIPFS.Api.error_response()
  def set(key, value) when is_binary(key) and is_binary(value) do
    post_query("/config?arg=" <> key <> "&arg=" <> value, query: [json: true, bool: false])
    |> okify()
  end

  @spec set(binary, boolean) :: {:ok, any} | MyspaceIPFS.Api.error_response()
  def set(key, value) when is_bitstring(key) and is_boolean(value) do
    post_query("/config?arg=" <> key <> "&arg=#{value}", query: [json: false, bool: true])
    |> okify()
  end

  @doc """
  Apply profile to config.

  ## Parameters
  profile: The profile to apply.

  ## Options
  https://docs.ipfs.tech/reference/kubo/rpc/#api-v0-config-profile-apply
  ```
  [
    `dry-run` - <bool>, # Dry run.
  ]
  ```
  """
  @spec profile_apply(binary(), list()) :: {:ok, any} | MyspaceIPFS.Api.error_response()
  def profile_apply(profile, opts \\ []) when is_bitstring(profile) do
    post_query("/config/profile/apply?arg=" <> profile, query: opts)
    |> okify()
  end

  @doc """
  Replace the config with the given JSON file.

  ## Parameters
  fspath: The path to the config file to use.
  """
  @spec replace(Path.t()) :: {:ok, any} | MyspaceIPFS.Api.error_response()
  def replace(fspath) do
    multipart(fspath)
    |> post_multipart("/config/replace")
    |> okify()
  end

  @doc """
  Show the current config.
  """
  @spec show() :: {:ok, any} | MyspaceIPFS.Api.error_response()
  def show() do
    post_query("/config/show")
    |> okify()
  end
end
