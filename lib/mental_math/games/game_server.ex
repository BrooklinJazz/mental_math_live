defmodule MentalMath.Games.GameServer do
  use GenServer
  alias MentalMath.RandomTrivia
  alias MentalMath.SingleDigitAddition
  # Callbacks
  @score_table :score_table

  @impl true
  def init(_opts) do
    with :undefined <- :ets.whereis(@score_table) do
      :ets.new(@score_table, [:set, :named_table, :public])
      :ets.insert(@score_table, {"player 1", 0})
    end

    {:ok, %{current_trivia: new_trivia()}}
  end

  @impl true
  def handle_call(:current_question, _from, state) do
    {:reply, state.current_trivia.question, state}
  end

  @impl true
  def handle_call(:current_trivia, _from, state) do
    {:reply, state.current_trivia, state}
  end

  @impl true
  def handle_call(:score, _from, state) do
    {:reply, state.score, state}
  end

  @impl true
  def handle_call({:answer, answer}, _from, state) do
    with true <- answer == state.current_trivia.answer do
      prev_score = score("player 1")
      :ets.insert(@score_table, {"player 1", prev_score + 1})

      {:reply, true,
       %{
         state
         | current_trivia: new_trivia()
       }}
    end
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  def score(_) do
    case :ets.lookup(@score_table, "player 1") |> IO.inspect(label: "SCORE") do
      [{_, value}] ->
        value

      _ ->
        :ets.insert(@score_table, {"player 1", 0})
        0
    end
  end

  def current_question(server) do
    GenServer.call(server, :current_question)
  end

  def current_trivia(server) do
    GenServer.call(server, :current_trivia)
  end

  def answer(server, answer) do
    GenServer.call(server, {:answer, answer})
  end

  def new_trivia() do
    RandomTrivia.get(%SingleDigitAddition{})
  end
end
