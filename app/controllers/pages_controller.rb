class PagesController < ApplicationController

  def index
    if logged_in?
      redirect_to user_path(current_user.id)
    else
      @publications = Publication.all
      render
    end
  end
end