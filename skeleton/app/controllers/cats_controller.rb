class CatsController < ApplicationController
  before_action :require_current_user!, except: [:create, :new]

  def index
    debugger
    @cats = Cat.all
    render :index
  end

  def show
    debugger
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    debugger
    @cat = Cat.new
    render :new
  end

  def create
    debugger
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    debugger
    if current_user.cats
      @cat = Cat.owner.find(params[:id])
      render :edit
    end
  end

  def update
    debugger
    if current_user.cats
      @cat = Cat.owner.find(params[:id])
      if @cat.update_attributes(cat_params)
        redirect_to cat_url(@cat)
      else
        flash.now[:errors] = @cat.errors.full_messages
        render :edit
      end
    end
  end

  private

  def cat_params
    debugger
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
