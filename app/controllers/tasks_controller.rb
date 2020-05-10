class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  
  def index
      @tasks = current_user.tasks.order(id: :desc)  
  end
  
  def show
    
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskの登録に成功しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Taskの登録に失敗しました'
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = "id:#{@task.id}が正常に更新されました"
      
      redirect_to root_url
    else
      flash.now[:danger] = 'Taskの更新に失敗しました'
      render :edit  
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = "正常にid:#{@task.id}のTaskが削除されました"
    redirect_to root_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end

end
