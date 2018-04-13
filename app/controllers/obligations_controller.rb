class ObligationsController < ApplicationController
  before_action :authenticate_user!
  before_action :obligations, except: [:new]
  before_action :obligation, except: [:index, :new, :create]

  def index
    @title = 'Obligations'
    @links = [
      {
        title: 'New obligation',
        path: new_obligation_path,
      }
    ]
  end

  def show
    @title = "#{@obligation.title}"
    @links = [
      {
        title: 'New payment',
        path: new_obligation_payment_path(@obligation)
      },
      {
        title: 'Back',
        path: obligations_path
      }
    ]
  end

  def new
    @obligation = current_user.obligations.build
  end

  def edit
    @title = 'Update obligation'
    @links = [
      {
        title: 'Back',
        path: obligation_path(@obligation)
      }
    ]
  end

  def create
    @obligation = @obligations.build(obligation_params)
    if @obligation.save
      redirect_to obligations_path
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
