class FavoritesController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    current_user.fav(task)
    flash[:success] = 'タスクをお気に入りしました'
    redirect_to task
  end

  def destroy
    task = Task.find(params[:task_id])
    current_user.unfav(task)
    flash[:success] = 'タスクのお気に入りを解除しました。'
    redirect_to task
  end
end
