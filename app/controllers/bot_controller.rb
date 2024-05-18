require "cgi"

class BotController < ApplicationController

  # set question_id back to zero when the index page is refreshed
  before_action :set_question_id, only: [:home]
  # set the number of answered questions to zero upon refreshing
  before_action :set_questions_answered_number, only: [:home]
  before_action :check_database, only: [:start_game]

  def home
  end

  def start_game
=begin
    to keep track of how many questions the user answered;
    the OR= operator is used to assign zero only if it has not already been done
=end
    # session[:answered_questions] ||= 0

    question = Trivia.find(session[:question_id])
    render turbo_stream: [
      turbo_stream.replace("chat-buttons", partial: "/bot/partials/chat_box", locals: { question: question }),
      turbo_stream.append("chat-card", partial: "/bot/partials/answer_field")
    ]
  end

  # def stop_game
  #   render turbo_stream: turbo_stream.remove("chat-buttons")
  # end

  def submit_answer
    session[:questions_answered_number] += 1

    if params[:answer].downcase == Trivia.find(session[:question_id]).correct_answer.downcase
    # the key is the name we assigned to the name attribute in the view
      answer = "Correct"
    else
      answer = "Incorrect, here is the correct answer:\n" + Trivia.find(session[:question_id]).correct_answer + "\n"
    end

    session[:question_id] += 1

    next_question = Trivia.find(session[:question_id])

    render turbo_stream: turbo_stream.append(
      "chat-messages",
      partial: "/bot/partials/answer",
      locals: { answer: answer, next_question: next_question }
    )

  end

  private

  def set_question_id
    session[:question_id] = 1
  end

  def set_questions_answered_number
    session[:questions_answered_number] = 0
  end

  def check_database
=begin 
    if the db is empty,
    it means that the user opened the website for the first time and nobody opened it prior to him;
    we need to fetch questions
=end
    if Trivia.count.zero?
      fetch_and_populate_database
    # elif question_id is equal to the id of the last entry in the db, fetch more questions
    elsif session[:quesiton_id] == Trivia.last.id
      fetch_and_populate_database
    end
  end

  def fetch_and_populate_database
    response = HTTParty.get("https://opentdb.com/api.php?amount=20")
    parsed_response = response.parsed_response
    trivias = parsed_response["results"]
    for trivia in trivias do
      question_type = trivia["type"]
      difficulty = trivia["difficulty"]
      # to get rid of special charachters
      category = CGI.unescapeHTML(trivia["category"])
      question = CGI.unescapeHTML(trivia["question"])
      correct_answer = CGI.unescapeHTML(trivia["correct_answer"])
      Trivia.create(
        question_type: question_type,
        difficulty: difficulty,
        category: category,
        question: question,
        correct_answer: correct_answer
      )
    end
  end
end
