class PublicationsController < ApplicationController
  def index
  @publications = Publication.all
  end
  def new
    @publication = Publication.new
  end

  def create
    name = params[:publication][:name]
    description = params[:publication][:description]
    Publication.create(:name => name, :description => description)
    redirect_to '/publications'
    end
end
