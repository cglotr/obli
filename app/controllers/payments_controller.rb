# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :obligation, only: %i[index show new create destroy]
  before_action :payment, only: [:show]

  def index
    @payments = @obligation.payments.paginate(page: params[:page], per_page: 6).order(created_at: :desc)
    @title = @obligation.title
    @sub_title = "payments history"
    @links = [
      {
        title: "Back",
        path: obligation_path(@obligation)
      }
    ]
  end

  def show
    @title = @obligation.title
    @sub_title = "payment"
    @links = [
      {
        title: "Back",
        path: obligation_payments_path(@obligation)
      }
    ]
    @items = [
      {
        title: "Amount",
        content: format("#{@obligation.currency} %.2f", @payment.amount)
      },
      {
        title: "Created at",
        content: @payment.created_at
      },
      {
        title: "Updated at",
        content: @payment.updated_at
      }
    ]
    @can_delete = @payment.created_at.between?(Time.now.beginning_of_day, Time.now.end_of_day)
  end

  def new
    init_new
    @payment ||= Payment.new
  end

  def create
    @payment = @obligation.payments.build(payment_params)
    if @payment.save
      redirect_to obligation_path(@obligation)
    else
      init_new
      render :new
    end
  end

  def destroy
    @payment = @obligation.payments.find(params[:id])
    @payment.destroy
    redirect_to obligation_path(@obligation)
  end

  private

    def init_new
      @title = "New payment"
      @sub_title = "Create a new payment"
      @links = [
        {
          title: "Back",
          path: obligation_path(@obligation)
        }
      ]
      recent_payments_set = Set[]
      @obligation.payments.each do |payment|
        recent_payments_set.add(payment.amount)
      end
      @recent_payments = recent_payments_set.to_a.first(5)
    end

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
