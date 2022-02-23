class CatsController < ApplicationController
  before_action :require_user!, only: [:new, :create, :edit, :update]

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
    @cat.owner = current_user
    if @cat.save!
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    @cat = current_user.cats.find(params[:id])
    render :edit
  end

  def update
    @cat = current_user.cats.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :sex, :birth_date, :color, :description)
  end

  def ensure_editor_owns_cat

  end
end