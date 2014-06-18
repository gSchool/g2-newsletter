class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    if current_user.admin
      @article = Article.new(allowed_params.merge(publication_id: params[:publication_id]))
      if @article.save
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
end