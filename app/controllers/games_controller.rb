require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  # def score
  #   @result = if included(params[:word], params[:letters]) && valid(params[:word])
  #               "Congratulations! #{params[:word]} is a valid English word!"
  #             elsif !included(params[:word], params[:letters])
  #               "Sorry but #{params[:word]} cannot be built out of #{params[:letters]}"
  #             else
  #               "Sorry but #{params[:word]} does not seem to be a valid English word..."
  #             end
  # end

  def score
    @result = generate_score(params[:word], params[:letters])
  end

  def generate_score(word, grid)
    if included(word, grid) && valid(word)
      "Congratulations! #{word} is a valid English word!"
    elsif !included(word, grid)
      "Sorry but #{word} cannot be built out of #{grid}"
    else
      "Sorry but #{word} does not seem to be a valid English word..."
    end
  end

  def included(word, grid)
    # params[:word].chars.all? do |letter|
    #   params[:letters].include?(letter)
    # end
    word.chars.all? do |letter|
      grid.downcase.include?(letter)
    end
  end

  def valid(word)
    # url = "https://dictionary.lewagon.com/#{params[:word]}"
    url = "https://dictionary.lewagon.com/#{word}"
    json = URI.open(url).read
    results = JSON.parse(json)
    @found = results['found']
  end
end
