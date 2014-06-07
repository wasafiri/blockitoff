class TasksController < ApplicationController
  before_filter :list

  def index
    @tasks = list.tasks
  end

  def show
    @task = list.tasks.find(params[:id])
  end

  def new
    @list = List.find params[:list_id]
    @task = @list.tasks.new
  end

  def edit
    @task = list.tasks.find(params[:id])
  end

  def create
    @task = list.tasks.build(task_params)
    if @task.save
      flash[:notice] = "Task was saved successfully."
      # you only need the parent in the route for
      # :index, and :new
      # anything else, and you have the id
      # from the id you can get the task
      # from the task you can get the list
      # belongs_to :list
      # has_many :tasks
      redirect_to [@list]
    else
      flash[:error] = "Error creating task. Please try again."
    end
  end

  def update
    @task = list.tasks.find(params[:id])

    if @task.update_attributes(task_params)
      flash[:notice] = "Description was updated successfully."
      redirect_to @task
    else
      flash[:error] = "Error changing description. Please try again."
    end
  end

  def destroy
    @task = Task.find(params[:id])
  end

  def time_til_expiry
    expiry = :created_at + 7.days
    helper.distance_of_time_in_words(Time.now, expiry)
  end

  private

  def task_params
    params[:task].permit(:description)
  end

  def list
    @list = List.find(params[:list_id])
    @list
  end

end
