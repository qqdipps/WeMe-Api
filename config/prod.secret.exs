# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  "ecto://96bd6682-f2d7-44dc-8c10-3d634a01e1fc-user:pw-9de7751c-e8aa-494d-a2cc-4bbd3089d20b@postgres-free-tier-1.gigalixir.com:5432/96bd6682-f2d7-44dc-8c10-3d634a01e1fc" ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :weme_api, WeMeApi.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "2")

secret_key_base =
  "GGsk2KTPce8GyoezjCdDVmqxRofnrUBqI8aZ0GLqUiwovlDYZxCx+V/QkuXHgH1z" ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :weme_api, WeMeApiWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :weme_api, WeMeApiWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
