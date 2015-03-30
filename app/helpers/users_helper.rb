module UsersHelper

#OR mapovac nezabudni to dat prec TODO
  def find_by_index(index)
    return if index.nil?
    User.find_by_sql("SELECT * FROM users WHERE id = #{index}").first
  end

end
