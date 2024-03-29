defmodule MyspaceIPFS.Multibase do
  @moduledoc """
  MyspaceIPFS.Multibase is where the multibase commands of the IPFS API reside.
  """

  import MyspaceIPFS.Api
  import MyspaceIPFS.Utils
  alias MyspaceIPFS.MultibaseCodec

  @typedoc """
  A multibase codec.
  """
  @type codec :: %MyspaceIPFS.MultibaseCodec{
          name: binary(),
          code: non_neg_integer(),
          prefix: binary(),
          description: binary()
        }
  @typedoc """
  A multibase encoding.
  """
  @type encoding :: %MyspaceIPFS.MultibaseEncoding{
          name: binary,
          code: non_neg_integer()
        }

  @doc """
  Decode a multibase encoded string.

  ## Parameters
    `data` - Data to decode.
  """
  @spec decode!(binary) :: any | MyspaceIPFS.Api.error_response()
  def decode!(data) when is_binary(data) do
    multipart_content(data)
    |> post_multipart("/multibase/decode")
  end

  @spec decode!(list) :: any | MyspaceIPFS.Api.error_response()
  def decode!(data) when is_list(data) do
    Enum.map(data, &decode!/1)
  end

  @spec decode!(tuple) :: any | MyspaceIPFS.Api.error_response()
  def decode!({key, nil}), do: {key, nil}

  @doc """
  Decode a multibase encoded string.

  ## Parameters
    `data` - Data to decode.
  """
  @spec decode(binary) :: {:ok, binary()} | MyspaceIPFS.Api.error_response()
  def decode(data) when is_binary(data) do
    decode!(data)
    |> okify()
  end

  @spec decode(list) :: {:ok, list} | MyspaceIPFS.Api.error_response()
  def decode(data) when is_list(data) do
    Enum.map(data, &decode!/1)
    |> okify()
  end

  @spec decode(tuple) :: any | MyspaceIPFS.Api.error_response()
  def decode({key, nil}), do: {key, nil}

  @doc """
  Decode a multibase encoded file.

  ## Parameters
    `data` - File to decode.
  """
  @spec decode_file(Path.t()) :: {:ok, any} | MyspaceIPFS.Api.error_response()
  def decode_file(data) do
    multipart_content(data)
    |> post_multipart("/multibase/decode")
    |> okify()
  end

  @doc """
  Encode a string to a multibase encoded string.

  ## Parameters
    `data` - File to encode.

  ## Options
    `b` - Multibase encoding to use.
  """
  @spec encode!(binary, list()) :: any | MyspaceIPFS.Api.error_response()
  def encode!(data, opts \\ []) do
    multipart_content(data)
    |> post_multipart("/multibase/encode", query: opts)
  end

  @spec encode(binary, list) :: {:ok, binary()} | MyspaceIPFS.Api.error_response()
  def encode(data, opts \\ []) do
    encode!(data, opts)
    |> okify()
  end

  @doc """
  List available multibase encodings.

  ## Options
    prefix - Only list encodings with the given prefix.
    numeric - Only list encodings with the given numeric code.
  """
  @spec list(list()) ::
          {:ok, [codec()]} | MyspaceIPFS.Api.error_response()
  def list(opts \\ []) do
    post_query("/multibase/list", query: opts)
    |> filter_empties()
    |> Enum.map(&MultibaseCodec.new/1)
    |> okify()
  end

  @doc """
  Transcode a multibase encoded string.

  ## Parameters
    `data` - Data to transcode.

  ## Options
    `b` - Multibase encoding to use
  """
  @spec transcode(binary, list()) :: {:ok, any} | MyspaceIPFS.Api.error_response()
  def transcode(data, opts \\ []) do
    multipart_content(data)
    |> post_multipart("/multibase/transcode", query: opts)
    # FIXME: type goes here. Check it out.
    |> okify()
  end
end
