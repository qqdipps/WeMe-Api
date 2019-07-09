defmodule WeMeApi.Repo do
  use Ecto.Repo,
    otp_app: :weme_api,
    adapter: Ecto.Adapters.Postgres
end
