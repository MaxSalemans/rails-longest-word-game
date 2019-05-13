require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    9.times {@letters << ("A".."Z").to_a.sample}
  end

  def score
    kb = params[:letters].split(" ") unless params[:letters] == nil
    @guess = params[:guess]
    @score = score_and_message(@guess, kb)[0] unless @guess == nil
    @message = score_and_message(@guess, kb)[1]
  end

  def api_check(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user["found"]
  end

  def word_grid_check(attempt, grid)
    attempt.each_char.all? { |char| grid.include?(char.upcase) }
  end

  def count_letter(attempt, grid)
    attempt.each_char.all? { |char| attempt.count(char) <= grid.count(char.upcase) }
  end

  def calculate_score(attempt)
    attempt.size * 983 - 825
  end

  def score_and_message(attempt, grid)
    score = calculate_score(attempt)
    if api_check(attempt)
      if word_grid_check(attempt, grid) && count_letter(attempt, grid)
        [score, 'Well done!']
      else
        [0, "#{params[:guess]} is not in the grid!"]
      end
    else
      [0, "#{params[:guess]} is not an english word!"]
    end
  end
end
