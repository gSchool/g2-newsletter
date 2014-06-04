class PagesController < SecureController

  def index
    @publications = Publication.all
  end
end