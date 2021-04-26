class ChatRoomsController < ApplicationController
  
  
  
  def index
    current_user_chat_rooms = ChatRoomUser.where(user_id: current_user.id).map(&:chat_room) #自身のチャットルーム全てを配列として集める
    @chat_room_users=ChatRoomUser.includes(:user).where(chat_room: current_user_chat_rooms).where.not(user_id:current_user.id) #自身がが入るチャットルームにいる相手の中間テーブルを持ってくる
  end
  
  def create
    current_user_chat_rooms = ChatRoomUser.where(user_id: current_user.id).map(&:chat_room) #自身のチャットルーム全てを配列として集める
    chat_room = ChatRoomUser.where(chat_room: current_user_chat_rooms, user_id: params[:user_id]).map(&:chat_room).first
    if chat_room.blank?
      chat_room = ChatRoom.create #ルームの作成してから
      #中間テーブルに登録
      ChatRoomUser.create(chat_room: chat_room, user_id: current_user.id)
      ChatRoomUser.create(chat_room: chat_room, user_id: params[:user_id])
    end
    redirect_to action: :show, id: chat_room.id
  end

  def show
    @chat_room = ChatRoom.find(params[:id]) #ルーム取得
    @chat_room_user = @chat_room.chat_room_users.where.not(user_id: current_user.id).first.user #ルーム相手の情報
    @chat_messages = ChatMessage.where(chat_room: @chat_room) #message内容を取得
    @chat_message=ChatMessage.new
  end



end
