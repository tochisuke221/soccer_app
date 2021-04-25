class ChatRoomsController < ApplicationController
  
  def create
    current_user_chat_rooms = ChatRoomUser.where(user_id: current_user.id).map(&:chat_room) #自身のチャットルーム全てを配列として集める
    chat_room = ChatRoomUser.find_by(chat_room: current_user_chat_rooms, user_id: params[:user_id])

    if chat_room.blank?
      chat_room = ChatRoom.create #ルームの作成してから
      #中間テーブルに登録
      ChatRoomUser.create(chat_room: chat_room, user_id: current_user.id)
      ChatRoomUser.create(chat_room: chat_room, user_id: params[:user_id])
    end
    redirect_to user_chat_room_path(params[:user_id],chat_room)
  end
  def show
  end

end
