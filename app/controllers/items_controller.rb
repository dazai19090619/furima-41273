class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user

     logger.debug "current_user: #{current_user.inspect}"

    if @item.save
      redirect_to root_path
    else
      logger.debug @item.errors.full_messages
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :category_id,
      :status_id,
      :shipping_fee_id,
      :prefecture_id,
      :delivery_time_id,
      :price,
      :image
    )
  end
end