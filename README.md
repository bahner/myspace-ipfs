# IPFS RPC API client for Elixir

![](https://ipfs.io/ipfs/QmQJ68PFMDdAsgCZvA1UVzzn18asVcf7HVvCDgpjiSCAse)

## DEPRECATED: Use https://github.com/bahner/ex-ipfs instead. ##

The reason for starting a new IPFS module is that none of the others seem to work at all.

All commands added, but *not* verified. For your everyday IPFS operations the module should work by now. But no guarantees. :-) Please, please, please - file issues and feature requests.

## Configuration

The default should brobably be OK, but you may override the default with the environment variables.

```
export MYSPACE_IPFS_API_URL="http://127.0.0.1:5001"
```

## Documentation
The documentation is very unbalanced. I am feeling my way forward as to how much I should document here. Each command will receive a link to the official documentation at least.

## Usage
Make sure ipfs is running. Then you can start using the module. If ipfs isn't running, you may try `MyspaceIPFS.daemon()`.

To use do:
```elixir
alias MyspaceIPFS, as: IPFS
IPFS.id()

MyspaceIPFS.Refs.refs("/ipns/myspace.bahner.com")

alias MyspaceIPFS.Refs
Refs.local()

# Subscribe to a PubSub Channel and send the message to my inbox
MyspaceIPFS.PubSub.Channel.start_link(self(), "mychannel")
flush
```
Some commands, like channel and tail that streams data needs a pid to send messages to. 

The basic commands are in the MyspaceIPFS module. The grouped ipfs commands each have their separate module, eg. MyspaceIPFS.Refs, MyspaceIPFS.Blocks etc.
