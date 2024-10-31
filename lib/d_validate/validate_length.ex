defmodule DValidate.ValidateLength do
  @doc """
  Validates if a value has a length within a specified range or an exact length.

  ## Parameters
    - `field_name`: The name of the field being validated (atom).
    - `value`: The value whose length is being checked (string).
    - `opts`: Keyword list for validation options. Can be one of:
      - `min` and `max` for range validation.
      - `length` for exact length validation.

  ## Return values
    - `:ok` if the length of `value` is within the specified range or matches the exact length.
    - `{:error, field_name, "is too short"}` if the length is less than `min` or `length`.
    - `{:error, field_name, "is too long"}` if the length is greater than `max` or `length`.

  ## Examples

      iex> DValidate.ValidateLength.call(:field_name, "abc", min: 1, max: 3)
      :ok

      iex> DValidate.ValidateLength.call(:field_name, "a", min: 2, max: 5)
      {:error, :field_name, "is too short"}

      iex> DValidate.ValidateLength.call(:field_name, "abcdef", min: 1, max: 5)
      {:error, :field_name, "is too long"}

      iex> DValidate.ValidateLength.call(:field_name, "abc", length: 3)
      :ok

      iex> DValidate.ValidateLength.call(:field_name, "a", length: 5)
      {:error, :field_name, "is too short"}

      iex> DValidate.ValidateLength.call(:field_name, "abcdef", length: 5)
      {:error, :field_name, "is too long"}
  """
  def call(field_name, value, opts) when is_binary(value) and is_list(opts) do
    case opts do
      [min: min, max: max] -> validate_length_range(field_name, value, min, max)
      [length: length] -> validate_exact_length(field_name, value, length)
      _ -> {:error, field_name, "invalid options"}
    end
  end

  defp validate_length_range(field_name, value, min, max) do
    length = String.length(value)

    cond do
      length < min -> {:error, field_name, "is too short"}
      length > max -> {:error, field_name, "is too long"}
      true -> :ok
    end
  end

  defp validate_exact_length(field_name, value, length) do
    case String.length(value) do
      ^length -> :ok
      len when len < length -> {:error, field_name, "is too short"}
      _ -> {:error, field_name, "is too long"}
    end
  end
end
