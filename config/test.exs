use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :image_api, ImageApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :image_api, ImageApi.Repo,
  username: "postgres",
  password: "postgres",
  database: "image_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Image manipulation client
config :image_api, :image_manipulation_api, ImageApi.ImageManipulation.ImageManipulationFake

# Image store client
config :image_api, :image_store, ImageApi.ImageStore.ImageStoreFake
