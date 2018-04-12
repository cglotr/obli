class ObligationsController < ApplicationController
  before_action :authenticate_user!
  before_action :obligations, except: [:new]
  before_action :obligation, except: [:index, :new, :create]

  def index
  end

  def show
  end

  def new
    @obligation = current_user.obligations.build
  end

  def edit
  end

  def create
    @obligation = @obligations.build(obligation_params)
    if @obligation.save
      redirect_to @obligation
    else
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

    def obligation
      @obligation = @obligations.find(params[:id])
    end

    def obligations
      @obligations = current_user.obligations
    end

    def obligation_params
      params.require(:obligation).permit(:title)
    end
end
