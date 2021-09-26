defmodule MentalMathWeb.GameLive.Index do
  use MentalMathWeb, :live_view
  alias MentalMath.Games.GameServer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, server} = GameServer.start_link()

    {:ok,
     assign(socket, score: GameServer.score(server), question: GameServer.current_question(server))}
  end

  def handle_event("answer") do
  end
end
