class OrdersUserSessionsController < ApplicationController
  def check_user
    @book_ids = params[:order][:book_ids].reject { |id| id == '' }

    unless params[:customer_email].present?
      @order = Order.new
      @order.errors[:base] << "Customer can't be blank"
      render 'orders/new'
    end

    if User.exists?(email: params[:customer_email])
      allow_user_to_sign_in
    else
      save_order
    end
  end

  def new
    @order = Order.new
    @book_ids = params[:book_ids]
    @customer_email = params[:customer_email]
  end

  def create
    sign_in_user
    save_order
    redirect_to orders_path
  end

  private

  def allow_user_to_sign_in
    redirect_to new_orders_user_session_path(
      customer_email: params[:customer_email],
      book_ids: @book_ids
    )
  end

  def save_order
    OrderFactory.create(
      customer_email: params[:customer_email],
      book_ids: params[:order][:book_ids]
    )
  end

  def sign_in_user
    user = User.find_for_authentication(email: params[:customer_email])
    user = user&.valid_password?(params[:password]) ? user : nil
    sign_in(user, scope: :user)
  end
end
