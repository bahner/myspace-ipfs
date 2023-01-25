defmodule MyspaceIpfs.Name do
  @moduledoc """
  MyspaceIpfs.Name is where the name commands of the IPFS API reside.
  """
  import MyspaceIpfs.Api
  import MyspaceIpfs.Utils

  @typep okresult :: MyspaceIpfs.okresult()
  @typep path :: MyspaceIpfs.path()
  @typep opts :: MyspaceIpfs.opts()

  @doc """
  Publish IPNS names.

  ## Parameters
    `path` - Path to be published.

  ## Options
  https://docs.ipfs.io/reference/http/api/#api-v0-name-publish
  ```
  [
    resolve: <bool>, # Resolve given path before publishing.
    lifetime: <string>, # Time duration that the record will be valid for.
    allow-offline: <bool>, # Run offline.
    ttl: <string>, # Time duration this record should be cached for (caution: experimental).
    key: <string>, # Name of the key to be used or a valid PeerID, as listed by 'ipfs key list -l'.
    quieter: <bool>, # Write minimal output.
    ipns-base: <string>, # IPNS key base.
  ]
  ```
  """
  @spec publish(path, opts) :: okresult
  def publish(path, opts \\ []),
    do:
      post_query("/name/publish?arg=" <> path, query: opts)
      |> handle_api_response()
      |> okify()

  @doc """
  Resolve IPNS names.

  ## Parameters
    `name` - IPNS name to resolve.

  ## Options
  https://docs.ipfs.io/reference/http/api/#api-v0-name-resolve
  ```
  [
    recursive: <bool>, # Resolve until the result is not an IPNS name.
    nocache: <bool>, # Do not use cached entries.
    dht-record-count: <int>, # Number of records to request for DHT resolution.
    dht-timeout: <string>, # Maximum time to collect values during DHT resolution eg "30s".
    stream: <bool>, # Stream the output as a continuous series of JSON values.
  ]
  ```
  """
  @spec resolve(path, opts) :: okresult
  def resolve(path, opts \\ []),
    do:
      post_query("/name/resolve?arg=" <> path, query: opts)
      |> handle_api_response()
      |> okify()

  @doc """
  Cancel a subscription to a topic.

  ## Parameters
  https://docs.ipfs.io/reference/http/api/#api-v0-pubsub-cancel
    `topic` - The topic to cancel the subscription to.
  """
  @spec pubsub_cancel(binary) :: okresult
  def pubsub_cancel(topic) do
    # with {:ok, base64topic} <- Multibase.encode(topic) do
    post_query("/name/pubsub/cancel?arg=#{topic}")
    |> handle_api_response()
    |> okify()
  end

  @doc """
  Show the current pubsub state.
  """
  @spec pubsub_state :: okresult
  def pubsub_state do
    post_query("/name/pubsub/state")
    |> handle_api_response()
    |> okify()
  end

  @doc """
  Show the current pubsub subscribers.
  """
  @spec pubsub_subs :: okresult
  def pubsub_subs do
    post_query("/name/pubsub/subs")
    |> handle_api_response()
    |> okify()
  end
end