defmodule MentalMath.Repo do
  use Ecto.Repo,
    otp_app: :mental_math,
    adapter: Ecto.Adapters.Postgres
end
