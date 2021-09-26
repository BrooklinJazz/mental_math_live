defmodule MentalMathWeb.GameLiveTest do
  use MentalMathWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  describe "Index" do
    test "display active game", %{conn: conn} do
      assign(conn, :test, "value")
      {:ok, _index_live, html} = live(conn, Routes.game_index_path(conn, :index))

      assert html =~ "Live Game In Progress"
      assert html =~ "Score: 0"
    end
  end
end
