module TestsHelper
  def choose_random_questions(id, count)
    Question.find_by_sql("SELECT x.id, x.question_name, x.topic_id FROM
      (
        SELECT DISTINCT ON (q.id) q.id, q.question_name,q.topic_id FROM questions q JOIN answers a ON a.question_id = q.id WHERE q.topic_id = #{id}
      ) x
      ORDER BY RANDOM()
      LIMIT #{count}")
  end

  def find_topic(topic_id)
    Topic.find(topic_id)
  end

  def unset_test_active
    @test_active = false
  end

  def set_test_active
    @test_active = true
  end

  def is_test?
    @test_active
  end

  def set_question_analyzation(value)
    @q_analyzation = value
  end

  def show_question_analyzation
    @q_analyzation ||= false;
    @q_analyzation
  end

  def check_duration(test)
    duration = test[:duration].strftime("%H").to_i * 3600 + test[:duration].strftime("%M").to_i * 60
    starting_date = test.starting_date
    check_time = (DateTime.now.to_f - starting_date.to_f)
    if(check_time < duration.to_f)
      true
    else
      false
    end
  end

end
