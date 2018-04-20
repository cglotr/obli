class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :obligation, only: [:index, :show, :new, :create, :destroy]
  before_action :payment, only: [:show]

  def index
    @payments = @obligation.payments.paginate(page: params[:page], per_page: 6).order(created_at: :desc)
    @title = @obligation.title
    @sub_title = 'payments history'
    @links = [
      {
        title: 'Back',
        path: obligation_path(@obligation)
      }
    ]
  end

  def show
    @title = @obligation.title
    @sub_title = 'payment'
    @links = [
      {
        title: 'Back',
        path: obligation_payments_path(@obligation)
      }
    ]
    @items = [
      {
        title: 'Amount',
        content: "#{@obligation.currency} %.2f" % [@payment.amount]
      },
      {
        title: 'Created at',
        content: @payment.created_at
      },
      {
        title: 'Updated at',
        content: @payment.updated_at
      }
    ]
  end

  def new
    @title = 'New payment'
    @links = [
      {
        title: 'Back',
        path: obligation_path(@obligation)
      }
    ]
  end

  def create
    @payment = @obligation.payments.create(payment_params)
    redirect_to obligation_path(@obligation)
  end

  def destroy
    @payment = @obligation.payments.find(params[:id])
    @payment.destroy
    redirect_to obligation_path(@obligation)
  end

  private

    def obligation
      @obligation = Obligation.find(params[:obligation_id])
    end

    def payment
      @payment = @obligation.payments.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:amount)
    end
end
