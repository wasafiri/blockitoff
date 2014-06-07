class TaskCompletionController < ApplicationController
  def update
    task = Task.find(params[:id])
    task.complete!
    redirect_to @task
  end

  def destroy
    task = Task.find(params[:id])
    # you can finish it
    # I would also seperate this from a task
    # make a model task_completion
    # when you 'complete' a task
    # you create a new task_completion
    # if you want to set it to uncomplete
    # you can have a another one marked
    # uncomplete, and then you would
    # look at the most recent item in
    # the 'completion log' to know the status
    # it is immutable this way
    # you are fighting way to many rails standards
  end
end
