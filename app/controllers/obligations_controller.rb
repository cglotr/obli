# frozen_string_literal: true

class ObligationsController < ApplicationController
  before_action :authenticate_user!
  before_action :obligations, except: [:new]
  before_action :obligation, except: %i[index new create]

  def index
    @title = "Obligations"
    @sub_title = "your payment obligations"
    @links = [
      {
        title: "New",
        path: new_obligation_path
      }
    ]
  end

  def show
    @title = @obligation.title.to_s
    @sub_title = "recent payments"
    @links = [
      {
        title: "New",
        path: new_obligation_payment_path(@obligation)
      },
      {
        title: "Payments",
        path: obligation_payments_path(@obligation)
      },
      {
        title: "Back",
        path: obligations_path
      }
    ]
    @payments = @obligation.payments.order(created_at: :desc).limit(6)
    @this_month_payment = @payments.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month).first
    @can_delete = @obligation.created_at.between?(Time.now.beginning_of_day, Time.now.end_of_day)
  end

  def new
    init_new
    @obligation = current_user.obligations.build
  end

  def edit
    @title = "Update obligation"
    @links = [
      {
        title: "Back",
        path: obligation_path(@obligation)
      }
    ]
  end

  def create
    @obligation = @obligations.build(obligation_params)
    if @obligation.save
      redirect_to obligations_path
    else
      init_new
      render :new
    end
  end

  def update
    if @obligation.update(obligation_params)
      redirect_to @obligation
    else
      render :edit
    end
  end

  def destroy
    @obligation.destroy
    redirect_to obligations_path
  end

  private

    def init_new
      @title = "New obligation"
      @sub_title = "Create a new payment obligation"
      @links = [
        {
          title: "Back",
          path: obligations_path
        }
      ]
    end

    def obligation
      @obligation = @obligations.find(params[:id])
    end

    def obligations
      @obligations = current_user.obligations.order(title: :asc)
    end

    def obligation_params
      params.require(:obligation).permit(:title, :currency)
    end
end
