class WelcomeController < ApplicationController
  def index
    
  end
  
  def about
    @flov = User.find_by_username('flov')
  end
end
