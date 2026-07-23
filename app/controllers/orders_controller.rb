class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
  if @item.user_id == current_user.id
    redirect_to root_path
    return
  end

  if @item.order.present?
    redirect_to root_path
    return
  end

  gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  @order_address = OrderAddress.new
end

  def create
    @order_address = OrderAddress.new(order_params)

    if @order_address.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]

      begin
        Payjp::Charge.create(
          amount: @item.price,
          card: params[:token],
          currency: "jpy"
        )

        if @order_address.save
          redirect_to root_path
        else
          gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
          render :index, status: :unprocessable_entity
        end

      rescue Payjp::InvalidRequestError
        gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
        flash.now[:alert] = "決済に失敗しました"
        render :index, status: :unprocessable_entity
      end

    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end