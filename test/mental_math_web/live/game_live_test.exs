defmodule MentalMathWeb.GameLiveTest do
  use MentalMathWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import MentalMath.GamesFixtures

  describe "Index" do
    test "lists current active game", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.game_index_path(conn, :index))

      assert html =~ "Live Game In Progress"
    end
  end
end
