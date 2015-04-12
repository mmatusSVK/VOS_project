module QuestionsHelper

  def find_by_index_question(index)
    return if index.nil?
    Question.find_by_sql("SELECT * FROM questions WHERE id = #{index}").first
  end

  def add_to_database_question(topic_id ,params)
    connection = ActiveRecord::Base.connection
    query = "INSERT INTO questions(topic_id, question_name, created_at, updated_at) VALUES (#{topic_id},\'#{params[:question_name]}\', current_date, current_date)"
    connection.execute(query)
  end

  def update_in_database_question(id, params)
    connection = ActiveRecord::Base.connection
    query = "UPDATE questions SET question_name = \'#{params[:question_name]}\' WHERE questions.id = #{id}"
    connection.execute(query)
  end

  def delete_in_database_question(id)
    ActiveRecord::Base.transaction do
      query = "DELETE FROM answers WHERE answers.question_id = #{id}"
      ActiveRecord::Base.connection.execute(query)

      query = "DELETE FROM questions WHERE questions.id = #{id}"
      ActiveRecord::Base.connection.execute(query)
    end
 #   connection = ActiveRecord::Base.connection
 #   query = "DELETE FROM questions WHERE questions.id = #{id}"
 #   connection.execute(query)
  end

  def current_question(index)
    @current_question ||= find_by_index_question(index)
  end

end
