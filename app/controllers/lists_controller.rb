class ListsController < ApplicationController
  respond_to :json, :html

  def index
    @lists = List.all
    respond_with(@lists)
  end

  def new
    @list = List.new
    respond_with @list
  end

  def show
    @list = List.find(params[:id])
    @tasks = @list.tasks
    respond_with @list, @tasks
  end

  def edit
    @list = List.find(params[:id])
    respond_with @list
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
    respond_with @list
  end

  def update
    @list = List.find(params[:id])
    authorize @list
    if @list.update_attributes(list_params)
      redirect_to @list
    else
      flash[:error] = "Error changing title. Please try again."
    end
    respond_with @list
  end

  def destroy
    @list = List.find(params[:id])

    if @list.destroy
      flash[:notice] = "\"#{@list}\" was deleted successfully."
      redirect_to lists_path
    else
      flash[:error] = "There was an error deleting the list."
    end
    respond_with @list
  end

  private

  def list_params
    params[:list].permit(:title)
  end

end
