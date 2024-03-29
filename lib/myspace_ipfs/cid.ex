defmodule MyspaceIPFS.Cid do
  @moduledoc """
  MyspaceIPFS.Cid is where the cid commands of the IPFS API reside.
  """
  import MyspaceIPFS.Api
  import MyspaceIPFS.Utils
  alias MyspaceIPFS.CidBase32CID
  alias MyspaceIPFS.MultibaseEncoding
  alias MyspaceIPFS.MultiCodec
  alias MyspaceIPFS.MultiHash

  @typedoc """
  A v1 CID. This is the new Base32 CID format, which is likely to last and is preferred.
  """
  @type base32cid :: %MyspaceIPFS.CidBase32CID{
          cid_str: binary,
          formatted: binary,
          error_msg: binary
        }

  @doc """
  Convert to base32 CID version 1.

  ## Parameters
  https://docs.ipfs.tech/reference/kubo/rpc/#api-v0-cid-base32
  `cid` - The CID to convert to base32.
  """

  @spec base32(binary()) :: {:ok, base32cid()} | MyspaceIPFS.Api.error_response()
  def base32(cid),
    do:
      post_query("/cid/base32?arg=" <> cid)
      |> CidBase32CID.new()
      |> okify()

  @doc """
  List available multibase encodings.

  """
  @spec bases(list()) :: {:ok, list} | MyspaceIPFS.Api.error_response()
  def bases(opts \\ []),
    do:
      post_query("/cid/bases", query: opts)
      |> Enum.map(&MultibaseEncoding.new/1)
      |> okify()

  @doc """
  List available CID codecs.

  ## Options
  https://docs.ipfs.tech/reference/kubo/rpc/#api-v0-cid-codecs

  `numeric` <bool> - Show codec numeric code.
  `supported` <bool> - Show only supported codecs.
  """
  @spec codecs(list()) ::
          {:ok, [MyspaceIPFS.multi_codec()]} | MyspaceIPFS.Api.error_response()
  def codecs(opts \\ []),
    do:
      post_query("/cid/codecs", query: opts)
      |> Enum.map(&MultiCodec.new/1)
      |> okify()

  @doc """
  Format and convert a CID in various useful ways.

  ## Parameters
  `cid` - The CID to format and convert.

  ## Options
  https://docs.ipfs.tech/reference/kubo/rpc/#api-v0-cid-format
  `f` <string> - printf style format string. Default: `%s`.
  `v` <string> - CID version.
  `b` <string> - Multibase to display CID in.
  `mc` <string> - Multicodec.
  """
  @spec format(binary(), list()) :: {:ok, any} | MyspaceIPFS.Api.error_response()
  def format(cid, opts \\ []),
    do:
      post_query("/cid/format?arg=" <> cid, query: opts)
      |> CidBase32CID.new()
      |> okify()

  @doc """
  List available multihashes.

  ## Options
  https://docs.ipfs.tech/reference/kubo/rpc/#api-v0-cid-hashes

  `supported` <bool> - Show only supported hashes.
  """
  @spec hashes(list()) ::
          {:ok, MyspaceIPFS.multi_hash()} | MyspaceIPFS.Api.error_response()
  def hashes(opts \\ []),
    do:
      post_query("/cid/hashes", query: opts)
      |> Enum.map(&MultiHash.new/1)
      |> okify()
end
