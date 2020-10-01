require 'json'
require "net/http"
require "open-uri"

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
                            puts "We can't wait to see you !"
                            puts "==============================================\n".green
                            puts "Do you want to continue ? yes / no"
                            acty = gets.chomp.to_s
                            if  acty == "yes" || acty == "Yes" || acty == "y" || acty == "Y"
                                puts "--- Welcome back ---"
                                puts "==============================================\n".green
                                next
                            elsif acty == "no" || acty == "No" || acty == "n" || acty == "N"
                                puts "Hope to see you soon!"
                                puts "==============================================\n".green
                                break
                            else
                                puts "It's not in options, please try it again !"
                                puts "==============================================\n".green
                                next
                            end
                        elsif act == "no" 
                            puts "Hope you can join in us on next time !"
                            puts "==============================================\n".green
                            puts "Do you want to continue ? yes / no"
                            actn = gets.chomp.to_s
                            if  actn == "yes" || actn == "Yes" || actn == "y" || actn == "Y"
                                next
                                puts "--- Welcome back ---"
                                puts "==============================================\n".green
                            elsif actn == "no" || actn == "No" || actn == "n" || actn == "N"
                                puts "Hope to see you soon!"
                                puts "==============================================\n".green
                                break
                            else
                                puts "It's not in options, please try it again !"
                                puts "==============================================\n".green
                                next
                            end
                        else
                            puts"It's not in the options, please try it again!"
                            puts "==============================================\n".green
                            next
                        end
                    elsif select == 2
                        puts "--- Welcome to Internet Searching ---"
                        puts "==============================================\n".green
                        user_search = ""
                        if ARGV.size == 0
                            puts "You need to enter something to search for"
                            puts "What would you like to search for?"
                            puts "==============================================\n".green
                            user_search = gets.chomp
                        elsif ARGV.size == 1
                            user_search = ARGV[0]
                        elsif ARGV.size >= 2
                            ARGV.each do |item|
                                user_search = user_search + item + "+"
                            end
                            user_search = user_search[0..-2]
                        end
                        url = "https://www.google.com/search?q=" + user_search
                        puts url
                        puts "Do you want to continue ? yes / no"
                            int = gets.chomp.to_s
                            if  int == "yes" || int == "Yes" || int == "y" || int == "Y"
                                next
                                puts "--- Welcome back ---"
                                puts "==============================================\n".green
                            elsif int == "no" || int == "No" || int == "n" || int == "N"
                                puts "Hope to see you soon!"
                                puts "==============================================\n".green
                                break
                            else
                                puts "It's not in options, please try it again !"
                                puts "==============================================\n".green
                                next
                            end
                    else
                        puts "It's not in options, please try it again !"
                        puts "==============================================\n".green
                        next
                    end
                else
                    puts "Password is incorrect, please try again! "
                    puts "==============================================\n".green
                    next
                end
            else
                puts "It's not a exsiting username, please try again !"
                puts "==============================================\n".green
                next
            end    
        elsif option == "3"
            puts "\n Welcome to Help System ! \n"
            puts "==============================================\n\n".green
            puts " 1- Regist New: Please flow the instruction and fill up the requirement.\n"
            puts " 2- Sign In: Please log in with your username and password first.you can have two options which they are Acitvities and Internet search, you can choose what you want.\n\n" 
            puts "==============================================\n\n".green
            puts "Do you want to continue ? yes / no".green
                int = gets.chomp.to_s
                if  int == "yes" || int == "Yes" || int == "y" || int == "Y"
                    next
                else
                    puts "See you next time!"
                    puts "==============================================\n\n".green
                    
                    break
                end
        elsif option == "1"
           
            puts "\nPlease enter username:"
            puts "==============================================\n".green
            username = gets.chomp
            people_array= users.each do |key, value|
            if usernames_array = users.map { |user| user["username"] }
                puts " 1111111111111111"
                next
            else
                user[:username] = username
                puts "Please enter your password:"
                puts "==============================================\n".green
                pwd = gets.chomp
                puts "Please enter your password again:"
                puts "==============================================\n".green
                pwd2 = gets.chomp
                if pwd2 == pwd
                    user[:password] = pwd
                    puts "Please enter your phone number: "
                    puts "==============================================\n".green
                    phone = gets.chomp.to_i
                    user[:phone] = phone
                    puts "Please enter your email address: "
                    puts "==============================================\n".green
                    email = gets.chomp
                    user[:email] = email
                    users.push(user)
                    
                else
                    puts "Please try again! "
                    puts "==============================================\n".green
                    next
                end
            end
            puts "Do you want continue ? yes / no"
            puts "==============================================\n".green
            want = gets.chomp.to_s
            if want == "yes"
                puts "Welcome come back"
                puts "==============================================\n".green
                next
            else
                break
            end
            
        else 
            puts "It's not include the options, Please try again!"
            puts "==============================================\n".green
            next
        end
        end
    File.write("username.json", JSON.dump(username_array))
  end
end

main = Main.new
main.run