module ObjectCreationMethods

  def create_user(attributes = {})
    user = new_user(attributes)
    user.save!
    user
  end

  def new_user(attributes = {})
    defaults =
      {
        :email => "user#{counter}@gmail.com",
        :password => 'password',
        :password_confirmation => 'password',
        :admin => false,
      }
    User.new(defaults.merge(attributes))
  end


  def create_publication(attributes = {})
    publication = new_publication(attributes)
    publication.save!
    publication
  end

  def new_publication(attributes = {})
    defaults =
    {
      :name => "Name#{counter}",
      :description => 'Description'

    }
    Publication.new(defaults.merge(attributes))
  end

  def counter
    @counter ||= -1
    @counter += 1
  end

end
