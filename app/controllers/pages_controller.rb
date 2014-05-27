class PagesController < ApplicationController

  def index
    @publications = Publication.all
  end
end