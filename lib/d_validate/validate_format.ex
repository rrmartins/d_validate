defmodule DValidate.ValidateFormat do
  @doc """
  Validates if a value matches the given regex pattern.

  ## Examples
      iex> DValidate.ValidateFormat.call("asabca123", ~r/^\\w+$/)
      {:ok}

      iex> DValidate.ValidateFormat.call("abc 123", ~r/^[\\w\\s]+$/)
      {:ok}

      iex> DValidate.ValidateFormat.call("abc@123", ~r/^\\w+$/)
      {:error, :field_name, "has an invalid format"}
  """
  def call(value, regex) do
    if Regex.match?(regex, value) do
      {:ok}
    else
      {:error, :field_name, "has an invalid format"}
    end
  end
end
