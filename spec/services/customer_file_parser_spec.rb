# frozen_string_literal: true

require "rails_helper"

RSpec.describe CustomerFileParser do
  describe "#call" do
    it "parses a valid file and returns customer hashes" do
      file = fixture_file_upload(
        "valid_customers.txt",
        "text/plain"
      )

      customers = described_class.new(file).call
      expect(customers.count).to eq(2)
      expect(customers.first[0][:name]).to eq("Sai")
    end

    it "raises error for invalid JSON format" do
      file = fixture_file_upload(
        "invalid_customers.txt",
        "text/plain"
      )

    customers, error = described_class.new(file).call

    expect(customers).to be_nil
    expect(error).to eq("Invalid JSON format detected in input file")
    end
  end
end
