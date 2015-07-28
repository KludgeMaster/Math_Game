=begin
 pseusocode  
  get userinfo#1
  get userinfo#2
  live=3

  repeat till one of players' live == 0
    generate question
    prompt for answer
    
    verify answer
    if right
      congratulate
    else
      humiliate
      live -= 1
    end
    
    switch player
  end

  verify winner of the game
  
  play this game again?
  
=end
# git push origin game_class

# git branch??
# colorization

require 'colorize'



class Player
  class InvalidGuessError < StandardError; end

  attr_accessor :name, :live, :score, :turn
  def initialize (name)
    @name = name
    @live = 3
    @score = 0
    @turn = 0
  end

  def gain_a_point
    @score += 1
  end

  def lose_live
    @live -= 1
  end

  def revive
    @live = 3
  end
=begin
  def turn= (num)
    @turn = num
  end

  def name
    @name
  end
=end

end

@question = []

def generate_question
  @question[0] = rand(20).floor
  @question[1] = rand(20).floor
  puts "What does #{@question[0]} plus #{@question[1]} equal?"
end

def prompt_player_for_answer
  loop do 
    # raise Player::InvalidGuessError, "Invalid input! Enter integer only."
    print @player1.turn == 1 ? @player1.name : @player2.name
    print ", What is your answer? "
    answer = gets.chomp
    return answer.to_i if answer.match(/^\d+$/)
  end
end

def answer_correct?(answer)
  answer == @question[0]+@question[1]
end

def init_players
  loop do
    print 'What\'s your name? (Player#1) '
    @player1 = Player.new(gets.chomp)
    break unless @player1.name.empty?
  end
  loop do
    print 'What\'s your name? (Player#2) '
    @player2 = Player.new(gets.chomp)
    break unless @player2.name.empty?
  end
=begin
  player1 = Player.new
  print 'What\'s your name? (Player#1) '
  player1.name = gets.chomp
  
  player2 = Player.new
  print 'What\'s your name? (Player#2) '
  player2.name = gets.chomp
=end
end

def print_score
  puts "Player#1, #{@player1.name}'s score is #{@player1.score.to_s.blue}."
  puts "Player#2, #{@player2.name}'s score is #{@player2.score.to_s.blue}."
end

def play_game
  init_players
  # puts "Hi, #{player1.name} and #{player2.name}!"
  #puts player1.inspect
  @player1.turn = 1
  
  loop do
    round = 0  
    while (@player1.live>0 && @player2.live>0)
      puts '================================================================='
      puts "====== Round #{round} =================================================="
      puts '================================================================='
      generate_question
      #puts @player1[:turn]== 1 ? "Player1" : "Player2"
      if answer_correct?(prompt_player_for_answer)
        @player1.turn == 1 ? @player1.score += 1 : @player2.score += 1
        puts "Wow you are genius!!!".green
      else
        @player1.turn == 1 ? @player1.live -= 1 : @player2.live -= 1
        puts "You IDIOT!!! You are wrong!!!".red
      end
      print_score
      @player1.turn, @player2.turn = @player2.turn, @player1.turn
      round += 1
    end

    puts @player1.live == 0 ? "Player1:" : "Player2:"
    puts "You LOST!"
    puts "Seriously #{@player1.live== 0 ? @player1.name : @player2.name},"
    puts "Does your mom know about this?"

    print "Do you want to play again?(y/n)"
    replay = gets.chomp
    @player1.revive
    @player2.revive
    break unless replay == 'y'
  end

end

play_game



