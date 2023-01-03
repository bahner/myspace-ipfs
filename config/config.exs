import Config

case config_env() do
  :dev ->
    config :tesla,
      adapter: Tesla.Adapter.Hackney

    config :myspace_ipfs,
      baseurl: "http://localhost:5001/api/v0",
      debug: true,
      deprecated: false,
      experimental: true

  :test ->
    config :tesla, Tesla.Middleware.Logger, debug: true

    config :myspace_ipfs,
      baseurl: "http://localhost:5001/api/v0",
      debug: true,
      experimental: true
end
