defmodule MentalMathWeb.GameLive.Index do
  use MentalMathWeb, :live_view
  alias MentalMath.Games.GameServer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, server} = GameServer.start_link()

    {:ok,
     assign(socket,
       server: server,
       score: GameServer.score(server),
       question: GameServer.current_question(server)
     )}
  end

  @impl true
  def handle_event("answer", %{"answer" => %{"value" => value}}, socket) do
    %{assigns: %{server: server}} = socket
    GameServer.answer(server, String.to_integer(value))

    {:noreply,
     assign(socket, score: GameServer.score(server), question: GameServer.current_question(server))}
  end
end
