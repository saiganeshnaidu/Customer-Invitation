# frozen_string_literal: true

module DistanceCalculator
  def self.distance_km(latitude, longitude)
    customer_lat_rad = to_radians(latitude)
    customer_lon_rad = to_radians(longitude)

    delta_lat = OFFICE_LATITUDE_RAD - customer_lat_rad
    delta_lon = OFFICE_LONGITUDE_RAD - customer_lon_rad

    haversine_value = Math.sin(delta_lat / 2)**2 +
                      Math.cos(customer_lat_rad) * Math.cos(OFFICE_LATITUDE_RAD) *
                      Math.sin(delta_lon / 2)**2

    central_angle = 2 * Math.atan2(Math.sqrt(haversine_value), Math.sqrt(1 - haversine_value))

    EARTH_RADIUS_KM * central_angle
  end

  def self.to_radians(degrees)
    degrees * Math::PI / 180
  end
end
