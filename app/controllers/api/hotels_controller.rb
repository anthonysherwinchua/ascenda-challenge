class Api::HotelsController < ApplicationController
  def index
    @hotels = HotelsPresenter.new(params).call
  end
end
