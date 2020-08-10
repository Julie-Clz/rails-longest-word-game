require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a
    @grid = 10.times.map { @letters.sample }
  end


  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end  

  def score
    @word = params[:input].upcase
    grid = params[:grid].split(" ")
    if  @word.chars.all? { |letter| grid.include?(letter) } == true
      if english_word?(@word)
        @score = "Congratulations! #{@word} is a valid English word!"
      else
        @score = "Sorry but #{@word} does not seem to be a valid English word..."
      end
    else
      @score = "Sorry but #{@word} can't be built out of #{grid.join(' ')}"
    end
  end
end
