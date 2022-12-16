defmodule MyspaceIPFS.Utils do
  @moduledoc """
  MyspaceIPFS.Utils is where common functions of the library are defined.

  Alias this library and you can run the commands via Utils.<cmd_name>.

      ## Examples

      iex> alias MyspaceIPFS.Utils, as: Utils
      iex> Api.get("Multihash_key")
      <<0, 19, 148, 0, ... >>
  """
  #alias Hex.Application

  import MyspaceIPFS.Connection
  @debug Application.get_env(:myspace_ipfs, :debug)
  @baseurl Application.get_env(:myspace_ipfs, :baseurl)

  # Not sure how and when to use this.
  # def write_file(raw, multihash) do
  #     File.write(multihash, raw, [:write, :utf8])
  # end

  # FIXME: Cleaup this mess.
  def request_post(file, path) do
    post(path, file)
  end

  def request_get(path) do
    post(path, "")
  end

  def request_get(path, arg) do
    post(path <> arg, "")
  end

  def request_get(path, arg, opts) do
    post(path <> arg, "", opts)
  end
end
