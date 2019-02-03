# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :exrancher,
  ecto_repos: [Exrancher.Repo]

# Configures the endpoint
config :exrancher, ExrancherWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8cmHwg/ehIxZ6uXS9XwuhSBCyqz7airfoPMLzfMC5cRgLzArM8QIswxd5OU0GY0R",
  render_errors: [view: ExrancherWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Exrancher.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# In your config/config.exs file
config :exrancher, Repo,
  adapter: Sqlite.Ecto2,
  database: "main_db"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
