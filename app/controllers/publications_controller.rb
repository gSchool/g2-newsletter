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
    @publication = Publication.create(:name => name, :description => description)
    if @publication.save
      flash[:notice] = "Publication Created"
      redirect_to publications_path
    else
      render :new
    end
  end
  def show
    @publication = Publication.find(params[:id])
  end
end