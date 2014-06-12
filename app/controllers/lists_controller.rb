class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @tasks = @list.tasks
  end

  def edit
    @list = List.find(params[:id])
    authorize @list
  end

  def create
    @list = List.new(list_params)
      if @list.save
        redirect_to list_path(@list), notice: "List was saved successfully."
      else
        flash[:error] = "Error creating list. Please try again."
        render :new
    end
  end

  def update
    @list = List.find(params[:id])
    authorize @list
    if @list.update_attributes(list_params)
      redirect_to @list
    else
      flash[:error] = "Error changing title. Please try again."
    end
  end

  def destroy
    @list = List.find(params[:id])

    if @list.destroy
      flash[:notice] = "\"#{@list}\" was deleted successfully."
      redirect_to lists_path
    else
      flash[:error] = "There was an error deleting the list."
    end
  end

  private

  def list_params
    params[:list].permit(:title)
  end

end
