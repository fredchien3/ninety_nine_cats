class CatrentalrequestsController < ApplicationController
  def new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    if @request.save!
      redirect_to cat_url(@request.cat_id)
    else
      render :new
    end
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to cat_url(@request.cat_id)
  end

  private
  def request_params
    params.require(:catrentalrequest).permit(:cat_id, :start_date, :end_date)
  end
end