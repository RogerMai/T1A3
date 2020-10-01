require 'json'

class Main
  attr_accessor :username_array

  def initialize
    is_file_exist = File.exists?("username.json")
    @username_array = is_file_exist ? JSON.parse(File.read("username.json")) : []
  end

  def run
    while true
        puts font.write("<  WELCOME TO OTMS  >").yellow
        # puts "-- Welcome to Office Terminal Management System --"
        puts "\nPlease select an option below:"
        puts "==============================================\n\n".green
        puts "1 - Regist New\n".green
        puts "2 - Sign In\n".green
        puts "3 - Help\n".green
        puts "4 - exit\n".green
        puts "==============================================\n\n".green
        puts "\n"

        option = gets.chomp

        if option == "4"
            puts "Please confirm yes / no "
            puts "==============================================\n".green
            answer = gets.chomp.to_s
            if answer == "yes"
                puts "Thanks for using"
                puts "==============================================\n".green
                break
            elsif answer == "no"
                puts "--- Welcome Back ---"
                puts "==============================================\n".green
                next
            else
                puts "Please type yes / no, and try again"
                puts "==============================================\n".green
                next
            end

    File.write("username.json", JSON.dump(username_array))
  end
end

main = Main.new
main.run