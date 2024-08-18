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
end
