class EntriesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @entries = Entry.paginate(page: params[:page], :per_page => 10)
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end
  
  def show
    @entry = Entry.find(params[:id])
    @user = @entry.user
    @comments = @entry.comments.paginate(page: params[:page], :per_page => 3)
    
    if signed_in?
      @comment = @entry.comments.build(user: current_user)
    end
  end

  def destroy
    @entry.destroy
    redirect_to root_url
  end
  
  private
  def entry_params
    params.require(:entry).permit(:title, :body)
  end
  
  def correct_user
    @entry = current_user.entries.find_by(id: params[:id])
    redirect_to root_url if @entry.nil?
  end
  
end
