class GameController < ApplicationController
  WORDS = %w(buzz lynx jinx jazz jazzy muzziness zigzagging jars junk mummifying grogginess)

  def start
    @word = WORDS.sample
    @guesses = []
    @word_masked = @word.gsub(/\\\\w/, '_').split('').map { |c| @guesses.include?(c) ? c : '_' }.join('')
    session[:guesses] = @guesses
    session[:word_masked] = @word_masked
  end

  def guess
    @word = session[:word]
    @guesses = params[:guesses].split(',')
    @word_masked = params[:word_masked]

    if @guesses.include?(params[:guess])
      @message = "You already guessed that letter. Try again."
    else
      @guesses << params[:guess]
      if @word.include?(params[:guess])
        @message = "Good guess! The word contains the letter #{params[:guess]}."
        @word_masked = @word.gsub(/[^#{params[:guess]}]/, '_')
      else
        @message = "Sorry, the word does not contain the letter #{params[:guess]}."
      end
    end
  end
end


