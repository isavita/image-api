defmodule ImageApi.Repo do
  use Ecto.Repo,
    otp_app: :image_api,
    adapter: Ecto.Adapters.Postgres
end
