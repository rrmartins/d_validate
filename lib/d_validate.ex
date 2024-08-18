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
end
