# Exyz

Provides a Z-combinator (but no Y-combinator) macro and function to facilitate
recursive anonymous functions.

## What is a Z-combinator?
It's a strict fixed point combinator.

### What's a strict fixed point combinator
It's a fixed point combinator for strict languages.

#### What's a fixed point combinator
It's a higher order function thats result, when used as input again, is the same.

#### What?
( ͡° ͜ʖ ͡° )

## Usage
With the function:
```elixir
iex(1)> factorial = Exyz.z_combinator fn(f) ->
...(1)>   fn
...(1)>     (1) -> 1
...(1)>     (n) -> n * f.(n - 1)
...(1)>   end
...(1)> end
iex(2)> factorial.(5) == 120
true
```

Or save two lines with the macro:
```elixir
iex(1)> factorial = Exyz.z fn
...(1)>   (1) -> 1
...(1)>   (n) -> n * this.(n - 1)
...(1)> end
iex(2)> factorial.(5) == 120
true
```
