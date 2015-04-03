module QuestionsHelper

  def find_by_index_question(index)
    return if index.nil?
    Question.find_by_sql("SELECT * FROM questions WHERE id = #{index}").first
  end

end
