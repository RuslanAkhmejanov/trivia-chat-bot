class ResetTrivias < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up do
        # Drop the table
        drop_table :trivias
        
        # Recreate the table with desired schema
        create_table :trivias do |t|
          t.string :question_type
          t.string :difficulty
          t.string :category
          t.string :question
          t.string :correct_answer

          t.timestamps
        end
      end

      dir.down do
        # Define the rollback behavior if needed
        drop_table :trivias
      end
    end
  end
end
