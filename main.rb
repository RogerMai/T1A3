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
        elsif option == "2"
            puts "\n--- Welcome to the Sign In system ---"
            puts "==============================================\n".green
            puts "Please enter your username: "
            puts "==============================================\n".green
            name = gets.chomp.to_s
            if users.map { |u| u["username"]}.include?(name)
                puts "Please enter your password: "
                puts "==============================================\n".green
                pwd = gets.chomp
                if users.map { |u| u["password"]}.include?(pwd)
                puts "==============================================\n".green
                    puts "\n--- Welcome to our family ---\n"
                    puts " 1 - Activities\n "
                    puts " 2 - Internet Searching\n"
                    puts "==============================================\n".green
                    select = gets.chomp.to_i
                    if select == 1
                        puts "--- Welcome to our activities ---"
                        puts "==============================================\n".green
                        puts "Do you want to join in the activity? yes / no"
                        act = gets.chomp.to_s
                        if  act == "yes" 
                            user = users.find { |user| user["username"] == name}
                            user[:doact] = act
                            users.delete_if { |user| user["username"] == name}
                            users.push(user)
                            File.write("people.json", JSON.dump(users))
                            p users.select { |user| user["doact"]}.map { |u| u["username"] }

    File.write("username.json", JSON.dump(username_array))
  end
end

main = Main.new
main.run