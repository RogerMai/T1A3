require 'json'

class Main
  attr_accessor :username_array

  def initialize
    is_file_exist = File.exists?("username.json")
    @username_array = is_file_exist ? JSON.parse(File.read("username.json")) : []
  end

  def run
    while true
      puts "\nPlease select an option below:"
      puts "a - add username"
      puts "r - read usernames"
      puts "e - exit program"
      puts "\n"

      option = gets.chomp

      if option == "e"
        break
      elsif option == "r"
        puts "\n"
        puts username_array.inspect
      elsif option == "a"
        puts "\nPlease enter username:"

        username = gets.chomp
        username_array.push(username)
      end
    end

    File.write("username.json", JSON.dump(username_array))
  end
end

main = Main.new
main.run