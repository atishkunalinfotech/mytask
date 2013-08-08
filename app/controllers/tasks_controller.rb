class TasksController < ApplicationController
  
  before_filter :authenticate
  def new
  	@task = Task.new
  end

  def index
  	@tasks = Task.find_all_by_user_id(current_user.id)
  end

  def show
  	@task = Task.find(params[:id])
  end

  def status
    #raise "#{params[:status]}"
   @tasks =  Task.find_all_by_status_and_user_id(params[:status], current_user.id)
   # render(:update) { |page| page.replace_html 'status', :partial => 'task_by_status' }
  end

  def edit
  	@task = Task.find(params[:id])
  end

  def create
  	@task = Task.new(params[:task])
  	if @task.save
  		redirect_to tasks_path
    else
      redirect_to root_url
    end
  end

  
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
        redirect_to tasks_path
        flash[:notice] = "updated"
    else
        redirect_to edit_task_path
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end
  private 

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
