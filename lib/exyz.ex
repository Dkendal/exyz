defmodule Exyz do
  @moddoc """
  Exyz provides a z-combinator (but no y-combinator) macro and function so that
  you can use recursion in anonymous functions with ease!
  """

  defmacro __using__(_) do
    quote do
      import Exyz, only: :macros
      require Exyz
    end
  end

  @doc ~s"""
  Z combinator macro, reference the function with `this`

  ## Examples
     iex(1)> factorial = Exyz.z fn
     ...(1)>   (1) -> 1
     ...(1)>   (n) -> n * this.(n - 1)
     ...(1)> end
     iex(2)> factorial.(5) == 120
     true
  """
  defmacro z g do
    quote do
      Exyz.z_combinator fn var!(this) ->
        unquote(g)
      end
    end
  end

  @doc ~s"""
  Z combinator, support recursion inside anonymous functions!
  defined as:
  λf. (λx. f (λy. x x y)) (λx. f (λy. x x y))

  ## Examples
     iex(1)> factorial = Exyz.z_combinator fn(f) ->
     ...(1)>   fn
     ...(1)>     (1) -> 1
     ...(1)>     (n) -> n * f.(n - 1)
     ...(1)>   end
     ...(1)> end
     iex(2)> factorial.(5) == 120
     true
  """
  def z_combinator f do
    combinator = fn(x) ->
      f.(fn(y) -> x.(x).(y) end)
    end
    combinator.(combinator)
  end
end
