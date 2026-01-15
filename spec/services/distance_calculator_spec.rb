# frozen_string_literal: true

require "rails_helper"

RSpec.describe DistanceCalculator do
  describe ".distance_km" do
    it "returns 0 when coordinates match the office location" do
      distance = described_class.distance_km(
        OFFICE_LATITUDE,
        OFFICE_LONGITUDE
      )

      expect(distance).to be_within(0.01).of(0)
    end

    it "returns a positive distance for a far location" do
      # Delhi coordinates
      distance = described_class.distance_km(28.6139, 77.2090)

      expect(distance).to be > MAX_DISTANCE_KM
    end

    it "Ensure it calculates the correct distance b/w Mumbai and Pune" do
      # Mumbai office: 19.0590317, 72.7553452
      # Pune: 18.5204, 73.8567
      expected_distance = 130.15 # Approx km, based on Haversine formula
      distance = described_class.distance_km(18.5204, 73.8567)
      expect(distance).to be_within(1.0).of(expected_distance)
    end
  end
end
