class GameController < ApplicationController
  WORDS = %w(buzz lynx jinx jazz jazzy muzziness zigzagging jars junk mummifying grogginess)

  def start
    @word = WORDS.sample
    @guesses = []
    @word_masked = @word.chars.map { |c| '_' }.join('')
    session[:guesses] = @guesses
    session[:word_masked] = @word_masked
    session[:word] = @word
  end

  def guess
    @word = session[:word]
    @guesses = session[:guesses]
    @word_masked = session[:word_masked]

    if @guesses.include?(params[:guess])
      @message = "You already guessed that letter. Try again."
    else
      @guesses << params[:guess]
      if @word.include?(params[:guess])
        @message = "Good guess! The word contains the letter #{params[:guess]}."
        @word_masked = @word.chars.map { |c| @guesses.include?(c) ? c : '_' }.join('')
      else
        @message = "Sorry, the word does not contain the letter #{params[:guess]}."
      end
    end

    session[:guesses] = @guesses
    session[:word_masked] = @word_masked
  end
end
