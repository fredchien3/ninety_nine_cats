class CatsController < ApplicationController
  def index # GET /cats
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show 
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save!
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update

  end

  private
  def cat_params
    params.require(:cat).permit(:name, :sex, :birth_date, :color, :description)
  end
end