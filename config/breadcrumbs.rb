crumb :root do
  link "投稿一覧", root_path
end

crumb :practice_new do
  link "新規投稿", new_user_registration_path
  parent :root
end
crumb :login do
  link "サインイン", new_user_session_path
  parent :root
end
crumb :user_new do
  link "新規登録", new_practice_path
  parent :root
end

crumb :search do
  link "検索結果"
  parent :root
end

crumb :chat_room do
  link "チャットルーム一覧"
  parent :root
end

crumb :rank do
  link "いいねランキング"
  parent :root
end

crumb :notification do
  link "通知一覧"
  parent :root
end

crumb :practice_show do |practice|
  link "投稿詳細", practice_path(practice)
  parent :root
end

crumb :practice_edit do |practice|
  link "投稿編集"
  parent :practice_show,practice
end





crumb :user_show do |user|
  link "#{user.name}さんの詳細", user_path(user)
  parent :root
end

crumb :password do |user|
  link "パスワード変更"
  parent :user_show,user
end

crumb :schedule do |user|
  link "予定表"
  parent :user_show,user
end

crumb :user_edit do |user|
  link "マイページ編集"
  parent :user_show,user
end

crumb :chat do |chat_room_user|  
  link "チャットルーム"
  parent :user_show,chat_room_user
end


crumb :game_index do 
  link "募集掲示板", games_path
  parent :root
end

crumb :game_show do |game|
  link "試合詳細", game_path(game)
  parent :game_index
end

crumb :game_new do 
  link "新規募集", new_game_path
  parent :game_index
end
