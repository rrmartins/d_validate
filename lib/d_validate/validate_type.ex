defmodule DValidate.ValidateType do
  @doc """
  Validates if a value is of the specified type.

  ## Examples

      iex> DValidate.ValidateType.call(1, :integer)
      :ok

      iex> DValidate.ValidateType.call("value", :string)
      :ok

      iex> DValidate.ValidateType.call(1.0, :float)
      :ok

      iex> DValidate.ValidateType.call("value", :integer)
      {:error, :integer, "is invalid"}

  """
  def call(value, :string) when is_binary(value), do: :ok
  def call(value, :integer) when is_integer(value), do: :ok
  def call(value, :float) when is_float(value), do: :ok
  def call(_, type), do: {:error, type, "is invalid"}
end
