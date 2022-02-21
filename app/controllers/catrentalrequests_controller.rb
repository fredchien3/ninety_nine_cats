class CatrentalrequestsController < ApplicationController
  def new
    render :new
  end

  def create
    @catrentalrequest = CatRentalRequest.new(catrentalrequest_params)
    if @catrentalrequest.save!
      redirect_to cat_url(@catrentalrequest.cat_id)
    else
      render :new
    end
  end

  private
  def catrentalrequest_params
    params.require(:catrentalrequest).permit(:cat_id, :start_date, :end_date)
  end
end