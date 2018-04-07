class PaymentsController < ApplicationController
  def create
    @obligation = Obligation.find(params[:obligation_id])
    @payment = @obligation.payments.create(payment_params)
    redirect_to obligation_path(@obligation)
  end

  private

    def payment_params
      params.require(:payment).permit(:amount)
    end
end
