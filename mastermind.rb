class Mastermind
  
  def initialize
      @secret_code = Array.new(4)
      @guess = []
      @guess_count = 0
      @max_guesses = 12
      @game_over = false
      @feedback = ""
      @answer = ""
      @difficulty = ""
  end
  
  def play_game
    pick_side
  end
  
  private
  
  # player picks the side for the game to start
  def pick_side
    puts "Do you wanna be a CODE MAKER or a CODE BREAKER?"
    puts "Type '0' to be a MAKER or '1' to be a BREAKER"
      @answer = gets.chomp
    if @answer == "0"
      puts "You are the CODE MAKER"
      create_code
    elsif @answer == "1"
      puts "You are the CODE BREAKER"
      puts "Computer created 4 digit code for you!"
      @secret_code = Array.new(4) { rand(1..6) }
      guess_code until end_game_player
    else
      puts "Invalid Input"
      pick_side
    end
  end
  
  def choose_difficulty
    puts "
    Now that you created the secret code\n 
    Please choose the difficulty of the AI that will decipher your code\n
    Enter '0' for dumb AI or '1' for smart AI
    "
    @difficulty = gets.chomp
    if @difficulty == "0"
      computer_guess_easy until end_game_computer
    elsif @difficulty == "1"
      computer_guess_hard until end_game_computer
    else
      puts "Invalid Input"
      choose_difficulty
    end
  end
         
  
  # code for the CODE MAKER
  def create_code
    puts "Create a code that consists of 4 digits (Range of numbers you can choose from is from 1 to 6)."
    @secret_code = gets.chomp.split("").map(&:to_i)
    if valid_input?(@secret_code)
      puts "You chose #{@secret_code.join} as your secret code"
      choose_difficulty
    else
      puts "Please enter a valid 4-digit code that includes numbers from 1 to 6"
      create_code
    end
  end
  
  
  # dumb AI for computer
  def computer_guess_easy
    @guess = Array.new(4) { rand(1..6) }
    @guess_count += 1
    puts "Computer guessed #{@guess.join}, it was #{@guess_count} guess."
    check_guess
  end
  
  # smart AI for computer  
  def computer_guess_hard
    if @guess_count == 0
      @guess = Array.new(4) { rand(1..6) }
    else
      @feedback.chars.each_with_index do |char, index|
        if char == "X"
          next
        elsif char == "O"
          @guess[index] = @secret_code[index]
        else
          @guess[index] = rand(1..6)
        end
      end
    end
    @guess_count += 1
    puts "Computer guessed #{@guess.join}, it was #{@guess_count} guess."
    check_guess
    end
  
  def valid_input?(input)
    input.length == 4 && input.all? { |digit| digit.between?(1, 6) }
  end
  
  #For player to guess the code
  def guess_code
    puts "Guess a code. YOU HAVE 12 attempts. Digits contain numbers from 1 to 6"
    @guess = gets.chomp.split("").map(&:to_i)
    if valid_input?(@guess)
      @guess_count += 1
      puts "You guessed #{@guess.join}, it was your #{@guess_count} guess."
      check_guess
    else
      puts "Please enter a valid 4-digit code that includes numbers from 1 to 6"
      guess_code
    end
  end
  
  def check_guess
    @feedback = ""
    @secret_code.each.with_index do |digit, index|
      if @guess[index] == digit
        @feedback << "X"
      elsif @secret_code.include?(@guess[index])
        @feedback << "O"
      else
        @feedback << "-"
      end
    end
    puts "Feedback: #{@feedback}"
  end
  
  #code to display computer guesses 
  def end_game_computer
    if @guess == @secret_code
      puts "You lose! Computer guessed the code in #{@guess_count} guesses"
      @game_over = true
    elsif @guess_count == @max_guesses
      puts "You win! Computer was not able to guess your secret code #{@secret_code.join}"
      @game_over = true
    end
  end
  
  #code for player to end game if he/she was correct or not
  def end_game_player
    if @guess == @secret_code
      puts "Congratulations! You guessed the code in #{@guess_count} guesses"
      @game_over = true
    elsif @guess_count == @max_guesses
      puts "You lose :(! No more guesses left. The code was #{@secret_code.join}"
      @game_over = true
    end
  end
  
end
  
puts "Welcome to Mastermind! The game where you can play as a Code Maker or Code Breaker!"
puts "-----------------------------------------------------------------------------------"
puts "The code is made up of 4 digits. Digits contain numbers from 1 to 6."
puts "-----------------------------------------------------------------------------------"
puts "FOR YOUR INFORMATION: X means that the digit is correct and in the correct position."
puts "FOR YOUR INFORMATION: O means that the digit is correct but in the wrong position."
puts "FOR YOUR INFORMATION: - means that the digit is not in the code"
puts "-----------------------------------------------------------------------------------"
    
game = Mastermind.new
game.play_game