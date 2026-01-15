# frozen_string_literal: true

class CustomerInvitationService
  def initialize(file)
    @file = file
  end

  # Public API called from controller
  def call
    customers, error = CustomerFileParser.new(@file).call
    return [ nil, error ] if error

    invited_customers = customers.select { |customer| within_range?(customer) }
                                  .sort_by { |customer| customer[:user_id] }
                                  .map { |customer| format_customer(customer) }
    [ invited_customers, nil ]
  end

  private

  def within_range?(customer)
    DistanceCalculator.distance_km(
      customer[:latitude].to_f,
      customer[:longitude].to_f
    ) <= MAX_DISTANCE_KM
  end

  def format_customer(customer)
    {
      user_id: customer[:user_id],
      name: customer[:name]
    }
  end
end
