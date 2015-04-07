module TopicsHelper

  #OR mapovac nezabudni to dat prec TODO
  def find_by_index_topic(index)
    return if index.nil?
    Topic.find_by_sql("SELECT * FROM topics WHERE id = #{index}").first
  end

  def add_to_database_topic(user_id ,params)
    connection = ActiveRecord::Base.connection
    query = "INSERT INTO topics(user_id, topic_name, information, created_at, updated_at) VALUES (#{user_id},\'#{params[:topic_name]}\', \'#{params[:information]}\', current_date, current_date)"
    connection.execute(query)
  end

  def update_in_database_topic(id, params)
    connection = ActiveRecord::Base.connection
    query = "UPDATE topics SET topic_name = \'#{params[:topic_name]}\', information = \'#{params[:information]}\' WHERE topics.id = #{id}"
    connection.execute(query)
  end

  def delete_in_database_topic(id)
    connection = ActiveRecord::Base.connection
    query = "DELETE FROM topics WHERE topics.id = #{id}"
    connection.execute(query)
  end

  def select_count_of_questions(index_of_topic)
    connection = ActiveRecord::Base.connection
    query = "SELECT COUNT(*) as count FROM questions q JOIN topics t ON t.id = q.topic_id WHERE t.id = #{index_of_topic  }"
    connection.execute(query)
  end

  def find_all_question_counts
    connection = ActiveRecord::Base.connection
    query = "SELECT COUNT(*) as count, t.id FROM topics t JOIN questions q ON t.id = q.topic_id GROUP BY t.id"
    connection.execute(query)
  end

  def current_topic(index)
    @current_topic ||= find_by_index_topic(index)
  end

end
