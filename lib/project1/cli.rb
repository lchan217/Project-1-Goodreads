class CommandLineInterface
  def call 
    greeting
    find_choices
    show_genres
  end 
  def greeting
    puts "Hello! Welcome to Goodreads."
  end 
  def find_choices
    Scraper.find_choices
  end 
  def show_genres 
    puts "Please choose a genre."
    Book.all.each_with_index do |book, i|
      puts "#{i+1}. #{book.genre}"
    end 
    puts "What genre would you like more information on?"
    answer = gets.strip.to_i
    if answer > 0 && answer < Book.all.length+1
      puts "Great choice! Here are some more details."
      chosen = Book.all[answer-1]
      Selected_genre.all.clear #this clears all selected books so there's not a duplicate output
      Scraper.get_detail(chosen)
    else 
      puts "This is not a valid number. Please try again."
      show_genres
    end
    show_selected_book(chosen)
  end 
  def show_selected_book(chosen) 
    
    Selected_genre.all.each_with_index do |book, i|
      puts "#{i+1}. #{book.title} by #{book.author} - number of votes: #{book.total_votes}"
    end 
    puts "Please pick a book or type 'back' to review more genres."
    answer = gets.strip
    if answer == "back"
      show_genres
    elsif answer.to_i > 0 && answer.to_i < Selected_genre.all.length+1
      chosen1 = Selected_genre.all[answer.to_i-1]
      Scraper.final_detail(chosen1)
    else 
      puts "This is not a valid number. Please try again."
      show_selected_book(chosen)
    end 
    show_final_book(chosen1)
  end
  def show_final_book(chosen1)
    puts "Author: #{chosen1.author} - Title: #{chosen1.title} - Ratings: #{chosen1.rating} - Number of Ratings:#{chosen1.number_of_ratings} - Description: #{chosen1.description}"
    puts "Thank you! Come again soon!"
  end 
end 