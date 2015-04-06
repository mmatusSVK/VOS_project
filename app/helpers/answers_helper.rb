module AnswersHelper

    def find_by_index_answer(index)
      return if index.nil?
      Answer.find_by_sql("SELECT * FROM answers WHERE id = #{index}").first
    end

    def add_to_database_answer(question_id ,params)
      connection = ActiveRecord::Base.connection
      query = "INSERT INTO answers(question_id, answer_name, is_right ,created_at, updated_at) VALUES (#{question_id},\'#{params[:answer_name]}\',#{is_right?(params[:is_right])}, current_date, current_date)"
      connection.execute(query)
    end

    def update_in_database_answer(id, params)
      connection = ActiveRecord::Base.connection
      query = "UPDATE answers SET answer_name = \'#{params[:answer_name]}\', is_right = #{is_right?(params[:is_right])} WHERE answers.id = #{id}"
      connection.execute(query)
    end

    def delete_in_database_answer(id)
      connection = ActiveRecord::Base.connection
      query = "DELETE FROM answers WHERE answers.id = #{id}"
      connection.execute(query)
    end


    private

    def is_right?(is_right_value)
      if is_right_value== "1"
        bool = 'true'
      else
        bool = 'false'
      end
    end
end
