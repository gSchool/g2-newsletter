require "stripe"
require 'publication'
require 'subscription'
require 'user'

class SubscriptionError < StandardError
end

class StripeError < StandardError
end

class SubscriptionCreator

  def initialize(current_user, publication_id, token)
    @current_user = current_user
    @publication_id = publication_id
    @token = token
  end

  def create_subscription
    Stripe.api_key = ENV['TEST_SECRET_KEY']
    begin
      if @current_user.stripe_id
        stripe_customer = Stripe::Customer.retrieve(@current_user.stripe_id)

      else
        stripe_customer = Stripe::Customer.create(
          :card => @token,
          :email => @current_user.email
        )

        stripe_customer_id = stripe_customer.id
        @current_user.update_attribute(:stripe_id, stripe_customer_id)
      end

      current_publication = Publication.find_by(id: @publication_id)
      publication_id_name = current_publication.name.gsub(" ", "_")
      stripe_customer.subscriptions.create(:plan => "#{publication_id_name}_basic")

      subscription = Subscription.new(publication_id: @publication_id, user_id: @current_user.id)
      if subscription.save
        return true
      else
        raise SubscriptionError, "There was a problem creating this Subscription, please contact an admin"
      end

    rescue Stripe::CardError => e
      body = e.json_body
      err = body[:error]
      raise StripeError, err[:message]
    rescue Stripe::StripeError
      raise StripeError, "There was a problem with Stripe, please contact the admin."
    end
  end

end