class PaymentRequestsController < ApplicationController
  def index
    @payment_requests = PaymentRequest.all
  end

  def accept
    PaymentRequest.find(params[:id]).accept

    redirect_to payment_requests_path
  end

  def reject
    PaymentRequest.find(params[:id]).reject

    redirect_to payment_requests_path
  end
end
