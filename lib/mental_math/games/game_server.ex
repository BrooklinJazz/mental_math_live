defmodule MentalMath.Games.GameServer do
  use GenServer
  alias MentalMath.RandomTrivia
  alias MentalMath.SingleDigitAddition
  # Callbacks

  @impl true
  def init(_opts) do
    {:ok, %{score: 0, current_trivia: new_trivia()}}
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
      {:reply, true,
       %{
         state
         | score: state.score + 1,
           current_trivia: new_trivia()
       }}
    end
  end

  def start_link(opts \\ %{}) do
    GenServer.start_link(__MODULE__, opts)
  end

  def score(server) do
    GenServer.call(server, :score)
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
