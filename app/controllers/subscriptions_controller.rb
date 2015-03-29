class SubscriptionsController < ApplicationController

  def new
    @stripe_btn_hash = {
      script: "src='https://checkout.stripe.com/checkout.js' class='stripe-button' data-key='#{ENV['stripe_publishable_key']}'",
      plan: {
        premium: "premium",
        premium_info: "data-description='Premium - $19.99 (Monthly)' data-panel-label='Subscribe' data-label='Subscribe'",
        free: "free",
        free_info: "data-description='Reader - Free' data-panel-label='Subscribe' data-label='Subscribe'"
      }
    }
  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
