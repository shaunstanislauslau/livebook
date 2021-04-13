import Config

# Configure the type of names used for distribution and the node name.
# By default a random short name is used.
# config :livebook, :node, {:shortnames, "livebook"}
# config :livebook, :node, {:longnames, "livebook@127.0.0.1"}

if config_env() == :prod do
  config :livebook, :token_authentication, false
  config :livebook, :auth_password, System.fetch_env!("LIVEBOOK_PASSWORD")

  # We don't need persistent session, so it's fine to just
  # generate a new key everytime the app starts
  secret_key_base = :crypto.strong_rand_bytes(48) |> Base.encode64()

  app_name = System.fetch_env!("APP_NAME")

  config :livebook, LivebookWeb.Endpoint,
    server: true,
    secret_key_base: secret_key_base,
    url: [host: "#{app_name}.herokuapp.com", port: 443],
    http: [
      ip: {127, 0, 0, 1},
      port: String.to_integer(System.get_env("PORT", "4000"))
    ]
end
