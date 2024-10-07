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

  describe "validate_length/3 with range options" do
    test "returns :ok when the value length is within the specified range" do
      assert DValidate.validate_length(:field_name, "abc", min: 1, max: 3) == :ok
      assert DValidate.validate_length(:field_name, "abcd", min: 2, max: 5) == :ok
    end

    test "returns an error when the value length is less than the minimum" do
      assert DValidate.validate_length(:field_name, "a", min: 2, max: 5) ==
               {:error, :field_name, "is too short"}

      assert DValidate.validate_length(:field_name, "", min: 1, max: 3) ==
               {:error, :field_name, "is too short"}
    end

    test "returns an error when the value length is greater than the maximum" do
      assert DValidate.validate_length(:field_name, "abcdef", min: 1, max: 5) ==
               {:error, :field_name, "is too long"}

      assert DValidate.validate_length(:field_name, "abcdefgh", min: 1, max: 7) ==
               {:error, :field_name, "is too long"}
    end

    test "returns an error for invalid options" do
      assert DValidate.validate_length(:field_name, "abc", invalid: 1) ==
               {:error, :field_name, "invalid options"}
    end
  end

  describe "validate_length/3 with exact length option" do
    test "returns :ok when the value length matches the specified length" do
      assert DValidate.validate_length(:field_name, "abc", length: 3) == :ok
      assert DValidate.validate_length(:field_name, "abcd", length: 4) == :ok
    end

    test "returns an error when the value length is less than the specified length" do
      assert DValidate.validate_length(:field_name, "a", length: 5) ==
               {:error, :field_name, "is too short"}

      assert DValidate.validate_length(:field_name, "abc", length: 5) ==
        {:error, :field_name, "is too short"}
    end

    test "returns an error when the value length is greater than the specified length" do
      assert DValidate.validate_length(:field_name, "abcdef", length: 5) ==
               {:error, :field_name, "is too long"}

      assert DValidate.validate_length(:field_name, "abcdefgh", length: 5) ==
               {:error, :field_name, "is too long"}
    end
  end

end
