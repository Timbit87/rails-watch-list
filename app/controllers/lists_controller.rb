class ListsController < ApplicationController
  def index
    if params[:query].present?
      @lists = List.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @lists = List.all
    end
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to list_path
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
