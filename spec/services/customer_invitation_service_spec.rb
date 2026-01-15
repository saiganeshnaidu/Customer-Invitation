# # frozen_string_literal: true

require "rails_helper"

RSpec.describe CustomerInvitationService do
  describe "#call" do
    it "returns only customers within 100 km and sorts by user_id" do
      # Prepare a "file" in memory
      file_content = <<~JSON
        {"latitude":"19.0590317","longitude":"72.7553452","name":"Sai","user_id":2}
        {"latitude":"18.5204","longitude":"73.8567","name":"Ganesh","user_id":1}
        {"latitude":"19.1000","longitude":"72.8000","name":"SG","user_id":3}
      JSON

      file = Tempfile.new("customers.txt")
      file.write(file_content)
      file.rewind

      customers, error = described_class.new(file).call

      # Sai and SG are within ~100km, Ganesh (Pune) is ~130km away
      expect(error).to be_nil
      expect(customers.map { |c| c[:name] }).to contain_exactly("Sai", "SG")
      expect(customers.map { |c| c[:user_id] }).to eq([ 2, 3 ]) # sorted by user_id
    ensure
      file.close
      file.unlink
    end

    it "returns empty array if no customers within range" do
      file_content = <<~JSON
        {"latitude":"18.5204","longitude":"73.8567","name":"Ganesh","user_id":1}
      JSON

      file = Tempfile.new("customers.txt")
      file.write(file_content)
      file.rewind

      customers, error = described_class.new(file).call

      expect(error).to be_nil
      expect(customers).to eq([])
    ensure
      file.close
      file.unlink
    end
  end
end
