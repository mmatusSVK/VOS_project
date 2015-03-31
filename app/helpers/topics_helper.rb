module TopicsHelper

  #OR mapovac nezabudni to dat prec TODO
  def find_by_index(index)
    return if index.nil?
    Topic.find_by_sql("SELECT * FROM topics WHERE id = #{index}").first
  end

end
