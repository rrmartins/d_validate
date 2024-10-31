defmodule DValidate.ValidateType do
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
  def call(value, field_name) do
    if value in [nil, ""] do
      {:error, field_name, "is required"}
    else
      :ok
    end
  end

  def validate_type(value, :string) when is_binary(value), do: :ok
  def validate_type(value, :integer) when is_integer(value), do: :ok
  def validate_type(value, :float) when is_float(value), do: :ok
  def validate_type(_, type), do: {:error, type, "is invalid"}
end
