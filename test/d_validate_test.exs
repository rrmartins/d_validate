defmodule DValidateTest do
  use ExUnit.Case
  doctest DValidate

  test "validate_presence/2" do
    assert DValidate.validate_presence("value", :field_name) == :ok
    assert DValidate.validate_presence(nil, :field_name) == {:error, :field_name, "is required"}
  end
end
