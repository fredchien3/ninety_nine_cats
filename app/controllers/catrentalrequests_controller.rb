class CatrentalrequestsController < ApplicationController
  before_action :require_user!, only: [:approve, :deny]
  before_action :require_cat_ownership!, only: [:approve, :deny]

  def new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    @request.user_id = current_user.id
    if @request.save!
      redirect_to cat_url(@request.cat_id)
    else
      render :new
    end
  end

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(@request.cat_id)
  end

  private
  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def request_params
    params.require(:catrentalrequest).permit(:cat_id, :start_date, :end_date)
  end

  def require_cat_ownership!
    return if current_user.owns_cat?(current_cat)
    redirect_to cat_url(current_cat)
  end
end