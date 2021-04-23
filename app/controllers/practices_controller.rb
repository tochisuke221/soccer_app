class PracticesController < ApplicationController
  before_action :set_practice,only:[:show,:destroy,:edit,:update]
  before_action :authenticate_user!,only:[:rank,:new,:show,:edit,:create,:update,:destroy,:search]
  before_action :move_to_root,only:[:edit,:update,:destroy]

  def index
    @practices=Practice.includes(:user).order("created_at DESC")
    @like = Like.new
  end


  def show
    @pcomment=Pcomment.new
    @pcomments=Pcomment.order("created_at DESC").where(practice_id:@practice.id)
    @ptags=@practice.ptags
  end

  def new
    @practice=PracticesPtag.new
  end


  def create 
    @practice=PracticesPtag.new(create_params)
    ptag_list=params[:practices_ptag][:name].split(",")
   
    if @practice.valid?
      flash[:notice]="投稿に成功しました"
      @practice.save(ptag_list)
      redirect_to root_path
    else
      flash[:alert]="投稿に失敗しました"
      render :new
    end
  end

  def edit
    @practices_ptag=PracticesPtag.new(title:@practice.title,content:@practice.content,category_id:@practice.category_id,hardlevel_id:@practice.hardlevel_id)
  end
  
  def update
    @practices_ptag=PracticesPtag.new(update_params)
    ptag_list=params[:practices_ptag][:name].split(",")
    
    if @practices_ptag.valid?
      flash[:notice]="編集に成功しました"
      @practices_ptag.update(ptag_list)
      redirect_to practice_path(@practice)
    else
      flash[:alert]="編集に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @practice.destroy
    redirect_to root_path
  end

  def search
    @practices = Practice.search(params[:keyword])
  end


  def rank
    @practices=Practice.includes(:liked_users).limit(5).sort{|a,b| b.liked_users.size <=> a.liked_users.size}
  end

  def ptaglist
    return nil if params[:keyword] == ""
    ptag = Ptag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: ptag }
  end

  private
  def create_params
    params.require(:practices_ptag).permit(:title,:content,:hardlevel_id,:name,:category_id,images:[]).merge(user_id:current_user.id)
  end
  def update_params
    params.require(:practices_ptag).permit(:title, :content,:hardlevel_id,:name,:category_id,images:[]).merge(user_id: current_user.id, practice_id: params[:id])
  end

  def set_practice
    @practice=Practice.find(params[:id])
  end

  def move_to_root 
    unless @practice.user.id==current_user.id
      redirect_to root_path
    end
  end
end
