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

  test "validate_format/2" do
    assert DValidate.validate_format("abc123", ~r/^\w+$/) == :ok

    assert DValidate.validate_format("abc 123", ~r/^\w+$/) ==
             {:error, :field_name, "has an invalid format"}
  end
end
