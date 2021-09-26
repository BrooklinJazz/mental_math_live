defprotocol MentalMath.RandomTrivia do
  def get(impl)
end

defmodule MentalMath.Trivia do
  defstruct [:question, :answer]
end

defimpl MentalMath.RandomTrivia, for: MentalMath.SingleDigitAddition do
  def get(_struct) do
    first = Enum.random(1..9)
    second = Enum.random(1..9)
    %MentalMath.Trivia{question: "What is #{first} + #{second}?", answer: first + second}
  end
end

defmodule MentalMath.SingleDigitAddition do
  defstruct type: "single_digit_addition"
end
