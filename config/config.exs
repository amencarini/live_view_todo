# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :live_view_todo, LiveViewTodoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "M4V8tgogWdJgXDMpvbEG4dTrutd1qccVLKy35xkKNMZ2s7HMeOOmX4bIivYR81to",
  render_errors: [view: LiveViewTodoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LiveViewTodo.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "LbaohEEMEnPpJQ6YVKMd88PROFqec+tO"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
