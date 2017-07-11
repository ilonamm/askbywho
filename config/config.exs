# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :askbywho, Askbywho.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "xPaUhGOWX+tsUeHVnFqIQxdRF3hMjVCQeVQuEJPLHRXLSRqaDZiqkeV++qmTbpKM",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Askbywho.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

# Configure db 
config :askbywho, ecto_repos: [Askbywho.Repo]

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Askbywho.User,
  repo: Askbywho.Repo,
  module: Askbywho,
  router: Askbywho.Router,
  messages_backend: Askbywho.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token]

config :coherence, Askbywho.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
