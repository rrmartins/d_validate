defmodule DValidate do
  @moduledoc """
  A module for validating input fields in Elixir applications.
  """

  alias DValidate.{
    ValidateFormat,
    ValidateLength,
    ValidatePresence,
    ValidateType
  }

  defdelegate validate_presence(value, field_name), to: ValidatePresence, as: :call
  defdelegate validate_type(value, type), to: ValidateType, as: :call
  defdelegate validate_format(value, regex), to: ValidateFormat, as: :call
  defdelegate validate_length(field_name, value, opts), to: ValidateLength, as: :call
end
