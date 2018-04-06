class ObligationsController < ApplicationController
  def index
    @obligations = Obligation.all
  end

  def show
    @obligation = Obligation.find(params[:id])
  end

  def new
    @obligation = Obligation.new
  end

  def create
    @obligation = Obligation.new(obligation_params)
    if @obligation.save
      redirect_to @obligation
    else
      render :new
    end
  end

  private

    def obligation_params
      params.require(:obligation).permit(:title)
    end
end
