class ObligationsController < ApplicationController
  def index
    @obligations = Obligation.all
  end

  def show
    @obligation = Obligation.find(params[:id])
  end

  def new
  end

  def create
    @obligation = Obligation.new(obligation_params)
    @obligation.save
    redirect_to @obligation
  end

  private

    def obligation_params
      params.require(:obligation).permit(:title)
    end
end
