class AddUserToAnswers < ActiveRecord::Migration[7.1]
  def change
    add_reference :answers, :user, null: false, foreign_key: true
    add_reference :answers, :question, null: false, foreign_key: true
  end
end
