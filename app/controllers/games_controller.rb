class GamesController < ApplicationController
  require 'open-uri'

  def new
    @letters = ("A".."Z").to_a.sample(10)
  end
  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    session[:score] ||= 0
    @score_message = ""
    word_found = JSON.parse(URI.parse("https://dictionary.lewagon.com/#{@word}").read)["found"]

    if word_found
      word_letters = @word.chars
      if word_letters.all? { |letter| @letters.count(letter) >= word_letters.count(letter) }
        session[:score] += @word.length
        @score_message = "Well done! #{@word} is a valid word."
      else
        @score_message = "#{@word} can't be built ouf of #{@letters}."
      end
    else
      @score_message = "Sorry, #{@word} is not an English valid word."
    end
  end
end
