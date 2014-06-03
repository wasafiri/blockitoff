class ListsController < ApplicationController
  def create
    @list = List.new(list_params)
    if @list.save
      flash[:notice] = "List was saved successfully."
    else
      flash[:error] = "Error creating list. Please try again."
    end
  end

  def show
    @list = List.find(params[:id])
  end

  def destroy
    @list = List.find(params[:id])
  end

  private

  def list_params
    params[:list].permit(:title)
  end

end
