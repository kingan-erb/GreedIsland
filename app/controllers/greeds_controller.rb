class GreedsController < ApplicationController
  def index
  	@greeds = Greed.all
  end
end
