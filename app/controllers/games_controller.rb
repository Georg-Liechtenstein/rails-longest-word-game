require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.shuffle.take(10)
  end

  def score
    answer = params[:word]
    letters = params[:letters]
    if letters.include?('answer')
      if english_word?(answer)
        @reply = "Comgratulations! #{answer} is a valid English Word!"
      else
        @reply = "Sorry but #{answer} does not seem to be a valid English word..."
      end
    else
      @reply = "Sorry but #{answer} can't be build out of #{letters}"
    end
    english_word?(answer)
    @json
  end

  def english_word?(answer)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{answer}")
    @json = JSON.parse(response.read)
    @json['found']
  end
end
