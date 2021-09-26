defmodule MentalMath.Games.GameServerTest do
  # doctest MentalMath.Games.GameServer
  alias MentalMath.Games.GameServer
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!(GameServer)
    %{registry: registry}
  end

  test "play game", %{registry: registry} do
    # GameServer.get_question()
    0 = GameServer.score(registry)
    %{answer: answer} = GameServer.current_trivia(registry)
    true = GameServer.answer(registry, answer)
    1 = GameServer.score(registry)
  end
end
