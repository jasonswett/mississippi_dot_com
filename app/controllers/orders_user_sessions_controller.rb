class OrdersUserSessionsController < ApplicationController
  def check_user
    @book_ids = params[:order][:book_ids].reject { |id| id == '' }

    if User.exists?(email: params[:customer_email])
      allow_user_to_sign_in and return
    end

    if current_user
      @order = OrderFactory.build(
        customer_email: current_user.email,
        book_ids: params[:order][:book_ids]
      )
      @order.save

      redirect_to orders_path
    else
      @order = OrderFactory.build(
        customer_email: params[:customer_email],
        book_ids: params[:order][:book_ids]
      )

      if @order.save
        redirect_to orders_path
      else
        render 'orders/new' and return
      end
    end
  end

  def new
    @order = Order.new
    @book_ids = params[:book_ids]
    @customer_email = params[:customer_email]
  end

  def create
    sign_in_user
    save_order(params[:customer_email])
  end

  private

  def allow_user_to_sign_in
    redirect_to new_orders_user_session_path(
      customer_email: params[:customer_email],
      book_ids: @book_ids
    )
  end

  def save_order(customer_email)
    OrderFactory.create(
      customer_email: customer_email,
      book_ids: params[:order][:book_ids]
    )

    redirect_to orders_path
  end

  def sign_in_user
    user = User.find_for_authentication(email: params[:customer_email])
    user = user&.valid_password?(params[:password]) ? user : nil
    sign_in(user, scope: :user)
  end
end
