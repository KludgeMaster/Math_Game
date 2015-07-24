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

@player1 = {
    name: "",
    turn: 1,
    live: 3 
  }
@player2 =  {
    name: "",
    live: 3,
    turn: 0
  }


@question = []

def generate_question
  @question[0] = rand(20).floor
  @question[1] = rand(20).floor
  puts "What does #{@question[0]} plus #{@question[1]} equal?"
end

def prompt_player_for_answer
  puts @player1[:turn]== 1 ? @player1[:name] : @player2[:name]
  print "What is your answer? "
  gets.chomp.to_i
end

def answer_correct?(answer)
  answer == @question[0]+@question[1]
end

def get_names
  print 'What\'s your name? (Player#1) '
  @player1[:name] = gets.chomp
  print 'What\'s your name? (Player#2) '
  @player2[:name] = gets.chomp
end

def revive
  @player1[:live] = 3
  @player2[:live] = 3
end


get_names
replay = 'y'

while (replay == 'y')
  while (@player1[:live]>0 && @player2[:live]>0)
    generate_question
    #puts @player1[:turn]== 1 ? "Player1" : "Player2"
    if answer_correct?(prompt_player_for_answer)
      puts "Wow you are genius!!!"
    else
      @player1[:turn]== 1 ? @player1[:live] -= 1 : @player2[:live] -= 1
      puts "You idiot!!! You are WRONG!!!"
    end
    @player1[:turn],@player2[:turn] = @player2[:turn], @player1[:turn]
  end

  puts @player1[:live]== 0 ? "Player1:" : "Player2:"
  puts "You LOST!"
  puts "Seriously #{@player1[:live]== 0 ? @player1[:name] : @player2[:name]},"
  puts "Does your mom know about this?"

  print "Do you want to play again?(y/n)"
  replay = gets.chomp
  revive
end




