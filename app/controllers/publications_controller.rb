class PublicationsController < SecureController
  def index
    @publications = Publication.all
    @user_subscriptions = current_user.subscriptions.map{ |sub| sub.publication_id}
  end

  def new
    @publication = Publication.new
  end

  def create
    @publication = Publication.new(allowed_parameters)
    if @publication.save
      flash[:notice] = "Publication Created"
      redirect_to publications_path
    else
      render :new
    end
  end

  def show
    @publication = Publication.find(params[:id])
    @articles = @publication.articles
  end

  def allowed_parameters
    params.require(:publication).permit(:name, :description)
  end
end
