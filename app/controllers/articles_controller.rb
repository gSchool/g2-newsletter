class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(allowed_params.merge(publication_id: params[:publication_id]))
    if @article.save
      redirect_to publication_path(params[:publication_id])
    else
      render :new, flash[:notice] = 'Article could not be saved'
    end
  end

  private
  def allowed_params
    params.require(:article).permit(:title, :description)
  end
end