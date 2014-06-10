class PagesController < ApplicationController

  def index
    if logged_in?
      redirect_to subscriptions_path
    else
      @publications = Publication.all
      render
    end
  end
end
