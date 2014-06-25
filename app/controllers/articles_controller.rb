class ArticlesController < ApplicationController
  def show
    publication = Publication.find(params[:publication_id])
    users_publications = current_user.subscriptions.map { |sub| sub.publication }
    if users_publications.include?(publication)
      @article = Article.find(params[:id])
    else
      render :file => 'public/404.html', :status => :not_found, :layout => false
    end
  end

  def new
    @article = Article.new
  end

  def create
    if current_user.admin
      @article = Article.new(allowed_params.merge(publication_id: params[:publication_id]))
      if @article.save
        article = Article.find(@article.id)
        send_emails(article)
        redirect_to publication_path(params[:publication_id])
      else
        flash[:notice] = 'Article could not be saved'
        render :new
      end
    else
      flash[:notice] = 'You do not have article creation privileges.'
      redirect_to root_path
    end
  end

  private
  def allowed_params
    params.require(:article).permit(:title, :description)
  end

  def send_emails(article)
    users = article.publication.subscriptions.includes(:user).map{|sub| sub.user}
    users.each do |user|
      NotifierEmailJob.new.async.subscription(user, article)
    end
  end
end