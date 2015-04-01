module TopicsHelper

  #OR mapovac nezabudni to dat prec TODO
  def find_by_index_topic(index)
    return if index.nil?
    Topic.find_by_sql("SELECT * FROM topics WHERE id = #{index}").first
  end

  def add_to_database(user_id ,params)
    connection = ActiveRecord::Base.connection
    query = "INSERT INTO topics(user_id, topic_name, information, created_at, updated_at) VALUES (#{user_id},\'#{params[:topic_name]}\', \'#{params[:information]}\', current_date, current_date)"
    connection.execute(query)
  end

  def update_in_database(id, params)
    connection = ActiveRecord::Base.connection
    query = "UPDATE topics SET topic_name = \'#{params[:topic_name]}\', information = \'#{params[:information]}\' WHERE topics.id = #{id}"
    connection.execute(query)
  end

end
