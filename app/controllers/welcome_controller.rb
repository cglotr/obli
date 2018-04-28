# frozen_string_literal: true

class WelcomeController < ApplicationController
  def hello
    redirect_to obligations_path if current_user
  end
end
