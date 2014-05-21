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

  def counter
    @counter ||= -1
    @counter += 1
  end

end
