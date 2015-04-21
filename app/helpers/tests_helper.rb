module TestsHelper
  def choose_random_questions(id, count)
    Question.find_by_sql("SELECT q.id, q.question_name,q.topic_id FROM questions q WHERE q.topic_id = #{id} ORDER BY RANDOM() LIMIT #{count}")
  end
end
