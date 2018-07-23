# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :connect_four,
  ecto_repos: [ConnectFour.Repo]

# Configures the endpoint
config :connect_four, ConnectFourWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xTMzZq70+jshGTE93zyj1+SCb00MnBFOufzzq7ew/sjsrRYAcNrfJqlDLeVZ24nU",
  render_errors: [view: ConnectFourWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ConnectFour.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
