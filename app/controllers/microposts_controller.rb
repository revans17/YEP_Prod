class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :like]
   before_action :correct_user, only:  :destroy
    before_action :admin_user, only: :destroy
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Post added!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
  end

  def points
   @title = "Likes"
   @micropost  = Micropost.find(params[:id])
   @microposts = @micropost.followers.paginate(page: params[:page])
   render 'points'
  end

  def upvote
       # @micropost = Micropost.find(params[:id])
       @micropost = Micropost.find(params[:id])
       Micropost.find(params[:id]).increment!(:like, 1)
       redirect_to root_url
  end




  private
  def increase_likes
    update_attributes(:like => :like + 1)
  end
    def micropost_params
      params.require(:micropost).permit(:content, :picture, :like)
    end
    def correct_user
       @micropost = Micropost.find(params[:id])
      # redirect_to root_url if @micropost.nil?
    end

    def admin_user
      # redirect_to(root_url) unless current_user.admin?
    end
end
