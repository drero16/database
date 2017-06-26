class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter do 
    redirect_to '/' unless current_user && current_user.admin?
  end
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @users= @users.email(params[:email]) if params[:email].present?
    @users = @users.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def all

  end
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def stats

  end

  def detailedstats
    if params[:tipo]=="animal"
      @data=Animal.all
      if params[:solved]=="true"
        @data=@data.where(solved: true)
        @title="Casos resueltos de animales encontrados"
      elsif params[:solved]=="false"
        @data=@data.where(solved: false)
        @title="Casos no resueltos de animales encontrados"
      elsif params[:solved]=="all"
        @title="Total de animales encontrados"
      end

    elsif params[:tipo]=="adoption"
      @data=Adoption.all
      if params[:solved]=="true"
        @data=@data.where(solved: true)
        @title="Casos resueltos de adopciones"
      elsif params[:solved]=="false"
        @data=@data.where(solved: false)
        @title="Casos no resueltos de adopciones"
      elsif params[:solved]=="all"
        @title="Total de adopciones publicadas"
      end      
    elsif params[:tipo]=="pet"
      @data=Pet.all
      if params[:solved]=="true"
        @data=@data.where(solved: true)
        @title="Casos resueltos de mascotas perdidas"
      elsif params[:solved]=="false"
        @data=@data.where(solved: false)
        @title="Casos no resueltos de mascotas perdidas"
      elsif params[:solved]=="all"
        @title="Total de publicaciones de mascotas perdidas"
      end      
    elsif params[:tipo]=="risk"
      @data=Risk.all
      if params[:solved]=="true"
        @data=@data.where(solved: true)
        @title="Casos resueltos de animales en riesgo"
      elsif params[:solved]=="false"
        @data=@data.where(solved: false)
        @title="Casos no resueltos de animales en riesgo"
      elsif params[:solved]=="all"
        @title="Total de publicaciones de animales en riesgo"
      end      
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :address, :phone, :sex, :role_id)
    end
end
