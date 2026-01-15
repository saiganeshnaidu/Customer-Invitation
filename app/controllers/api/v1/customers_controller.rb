class Api::V1::CustomersController < ApplicationController
  def invitees
    file = params[:file]
    return render_error("File is required", :bad_request) unless file

    customers, error = CustomerInvitationService.new(file).call

    if error
      render_error(error, :unprocessable_entity)
    else
      render json: { customers: customers }, status: :ok
    end
  end

  private

  def render_error(error, status)
    render json: { error: }, status: status
  end
end
