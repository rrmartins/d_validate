defmodule DValidateTest do
  use ExUnit.Case
  doctest DValidate

  test "validate_presence/2" do
    assert DValidate.validate_presence("value", :field_name) == :ok
    assert DValidate.validate_presence(nil, :field_name) == {:error, :field_name, "is required"}
  end

  test "validate_type/2" do
    assert DValidate.validate_type("value", :string) == :ok
    assert DValidate.validate_type(1, :integer) == :ok
    assert DValidate.validate_type(1.0, :float) == :ok
    assert DValidate.validate_type(123, :string) == {:error, :string, "is invalid"}
  end
end
