class TaskCompletionsController < ApplicationController

  def create
    task.mark_complete!
    redirect_to [@task.list, @task]
  end

  def destroy
    task.mark_incomplete!
    redirect_to [@task.list, @task]
  end

private

  def task
    @task ||= Task.find(params[:task_id])
  end
end
