module FeatureMethods

  def register_user(updated_attributes = {})
    default_attributes = {
      :email => 'email@email.com',
      :password => 'password',
      :password_confirmation => 'password'
    }

    attributes = default_attributes.merge(updated_attributes)

    visit '/'
    click_on 'Register'
    fill_in 'user[email]', with: attributes[:email]
    fill_in 'user[password]', with: attributes[:password]
    fill_in 'user[password_confirmation]', with: attributes[:password_confirmation]
    check 'terms'
    click_button 'Register'
  end

  def login_user(updated_attributes = {})
    default_attributes = {
      :email => 'email@email.com',
      :password => 'password'
    }

    attributes = default_attributes.merge(updated_attributes)

    visit '/'
    click_on 'Login'
    fill_in 'email', with: attributes[:email]
    fill_in 'password', with: attributes[:password]
    click_button 'login'
  end
end