defmodule DValidate do
  @moduledoc """
  A module for validating input fields in Elixir applications.
  """

  @doc """
  Validates if a value is present.

  ## Examples

      iex> DValidate.validate_presence("value", :field_name)
      :ok

      iex> DValidate.validate_presence(nil, :field_name)
      {:error, :field_name, "is required"}

  """
  def validate_presence(value, field_name) do
    if value in [nil, ""] do
      {:error, field_name, "is required"}
    else
      :ok
    end
  end

  @doc """
  Validates if a value is of the specified type.

  ## Examples
      iex> DValidate.validate_type(1, :integer)
      :ok

      iex> DValidate.validate_type("value", :string)
      :ok

      iex> DValidate.validate_type(1.0, :float)
      :ok

      iex> DValidate.validate_type("value", :integer)
      {:error, :integer, "is invalid"}
  """
  def validate_type(value, :string) when is_binary(value), do: :ok
  def validate_type(value, :integer) when is_integer(value), do: :ok
  def validate_type(value, :float) when is_float(value), do: :ok
  def validate_type(_, type), do: {:error, type, "is invalid"}

  @doc """
  Validates if a value matches the given regex pattern.

  ## Examples
      iex> DValidate.validate_format("abc 123", ~r/^\w+$/)
      {:error, :field_name, "has an invalid format"}

  """
  def validate_format(value, regex) do
    if Regex.match?(regex, value) do
      :ok
    else
      {:error, :field_name, "has an invalid format"}
    end
  end

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

      iex> DValidate.validate_length(:field_name, "abc", min: 1, max: 3)
      :ok

      iex> DValidate.validate_length(:field_name, "a", min: 2, max: 5)
      {:error, :field_name, "is too short"}

      iex> DValidate.validate_length(:field_name, "abcdef", min: 1, max: 5)
      {:error, :field_name, "is too long"}

      iex> DValidate.validate_length(:field_name, "abc", length: 3)
      :ok

      iex> DValidate.validate_length(:field_name, "a", length: 5)
      {:error, :field_name, "is too short"}

      iex> DValidate.validate_length(:field_name, "abcdef", length: 5)
      {:error, :field_name, "is too long"}
  """
  def validate_length(field_name, value, opts) when is_binary(value) and is_list(opts) do
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
