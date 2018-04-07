class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @obligation = Obligation.find(params[:obligation_id])
    @payment = @obligation.payments.create(payment_params)
    redirect_to obligation_path(@obligation)
  end

  def destroy
    @obligation = Obligation.find(params[:obligation_id])
    @payment = @obligation.payments.find(params[:id])
    @payment.destroy
    redirect_to obligation_path(@obligation)
  end

  private

    def payment_params
      params.require(:payment).permit(:amount)
    end
end
