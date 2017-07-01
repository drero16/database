class MypostsController < ApplicationController
	before_filter :authenticate_user!

	def all_animals
    @user=current_user
    @posts=@user.animals
    @posts=@posts.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

   def all_pets
    @user=current_user
    @posts=@user.pets
    @posts=@posts.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

   def all_risks
    @user=current_user
    @posts=@user.risks
    @posts=@posts.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

   def all_adoptions
    @user=current_user
    @posts=@user.adoptions
    @posts=@posts.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end
end
