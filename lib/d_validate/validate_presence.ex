defmodule DValidate.ValidatePresence do
  @doc """
  Validates if a value is present.

  ## Examples

      iex> DValidate.ValidatePresence.call("value", :field_name)
      :ok

      iex> DValidate.ValidatePresence.call(nil, :field_name)
      {:error, :field_name, "is required"}

  """
  def call(value, field_name) do
    if value in [nil, ""] do
      {:error, field_name, "is required"}
    else
      :ok
    end
  end
end
