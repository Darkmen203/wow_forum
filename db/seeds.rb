# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user1 = User.create(id: '1', provider: 'github', login: 'User1', token:"ne skazu")
user2 = User.create(id: '2', provider: 'github', login: 'User2', token:"ne skazu")

# Создаем первый вопрос
Question.create(
  title: 'Не могу установить Rails!',
  body: 'Выпадает странная ошибка',
  user_id: user1.id
)

# Создаем второй вопрос и сохраняем его в переменную
question = Question.create(
  title: 'Помогите с вебпакером',
  body: 'Я просто не знаю, зачем он нужен',
  user_id: user2.id
)
question.save
# Создаем ответ на второй вопрос
question.answers.create(
  body: 'Webpacker собирает ассеты.',
  user_id: user1.id
)
