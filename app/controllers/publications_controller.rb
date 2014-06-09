class PublicationsController < SecureController
  def index
    @publications = Publication.all
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.create(allowed_parameters)
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

  def allowed_parameters
    params.require(:publication).permit(:name, :description)
  end
end
