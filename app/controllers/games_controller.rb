require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a
    @grid = 10.times.map { @letters.sample }
  end

  def include?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end  

  def score
    @word = params[:input]
    grid = params[:grid].split(" ")
    if include?(@word.upcase, grid)
      if english_word?(@word)
        @score = "Congratulations! #{@word.upcase} is a valid English word!"
      else
        @score = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
      end
    else
      @score = "Sorry but #{@word.upcase} can't be built out of #{grid.join(' ')}"
    end
  end
end
