defmodule MentalMathWeb.GameLive.Index do
  use MentalMathWeb, :live_view

  alias MentalMath.Games
  alias MentalMath.Games.Game

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
