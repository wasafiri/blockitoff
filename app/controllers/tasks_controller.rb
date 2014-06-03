class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "Task was saved successfully."
    else
      flash[:error] = "Error creating task. Please try again."
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def complete!
    @task = Task.find(params[:id])
    if @tasks.update_attributes(completion)
      flash[:notice] = "Task was marked complete."
    else
      flash[:error] = "Could not mark task complete. Please try again"
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

  def completion
    params[:task].permit(:completed_at)
  end

end
