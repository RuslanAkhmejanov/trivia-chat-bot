class CreateTrivias < ActiveRecord::Migration[7.1]
  def change
    create_table :trivias do |t|
      t.string :question_type
      t.string :difficulty
      t.string :category
      t.string :question
      t.string :correct_answer

      t.timestamps
    end
  end
end
