class CommentsController < ApplicationController
  #before_action :set_comment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource :animal
  load_and_authorize_resource :pet
  load_and_authorize_resource :risk
  load_and_authorize_resource :adoption
  load_and_authorize_resource :comment, :through => [:animal,:pet,:risk,:adoption]
  # GET /comments
  # GET /comments.json
  def index
    #@comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
      end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id=current_user.id
    @comment.animal_id=params[:animal_id]
    @comment.pet_id=params[:pet_id]
    @comment.risk_id=params[:risk_id]
    @comment.adoption_id=params[:adoption_id]
    respond_to do |format|
      if @comment.save
          if (params[:animal_id])
            post=Animal.find(params[:animal_id])
            url="/animals/"+params[:animal_id]
          elsif (params[:pet_id])
            post=Pet.find(params[:pet_id])
            url="/pets/"+params[:pet_id]
          elsif (params[:risk_id])
            post=Risk.find(params[:risk_id])
            url="/risks/"+params[:risk_id]
          elsif (params[:adoption_id])
            post=Adoption.find(params[:adoption_id])
            url="/adoptions/"+params[:adoption_id]                 

          end

          user=post.user



        format.html { redirect_to :back, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
        format.js
        Spawnling.new do
            unless(@comment.user==user)
            title=@comment.user.name << " ha respondido a tu publicación."
            body=@comment.description
            pic_url=@comment.user.avatar.url
            noti=Notification.create(user: user, titulo: title, mensaje: body, url: url, seen: 0, pic_url: pic_url, comment: @comment)
            notify(user,title,body,notification_url(noti))
            #notify(user,noti.id)
            end
        end

       
          post.comments.select(:user_id).distinct.each do |userid|
            unless (@comment.user.id==userid)
              unless (user.id==userid)
                Spawnling.new do
                  title=@comment.user.name << " ha respondido una publicación donde comentaste."
              body=@comment.description
            pic_url=@comment.user.avatar.url
            noti=Notification.create(user_id: userid, titulo: title, mensaje: body, url: url, seen: 0, pic_url: pic_url, comment: @comment)
            notify(User.find(userid),title,body,notification_url(noti))
                end
              end
            end
          end
        

      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to :back , notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:description, :animal_id, :pet_id, :user_id, :risk_id, :adoption_id)
    end
end
