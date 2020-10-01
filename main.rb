require 'json'
require "net/http"
require "open-uri"
require 'tty-font'
require 'colorize'


class Main
  attr_accessor :users

  def initialize
    is_file_exist = File.exists?("people.json")
    @users = is_file_exist ? JSON.parse(File.read("people.json")) : []

  end


  def run
    user = {}
    while true
        font = TTY::Font.new(:doom)
        
        puts font.write("-<  WELCOME TO OTMS  >-").yellow
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
            puts "\nPlease confirm yes / no \n".yellow
            puts "\n==============================================\n".green
            answer = gets.chomp.to_s
            if answer == "yes"
                puts "\nThanks for using\n".yellow
                puts "\n==============================================\n".green
                break
            elsif answer == "no"
                puts "\n--- Welcome Back ---\n".yellow
                puts "\n==============================================\n".green
                next
            else
                puts "\nPlease type yes / no, and try again\n".red
                puts "\n==============================================\n".green
                next
            end
            
        elsif option == "2"
            puts "\n--- Welcome to the Sign In system ---".yellow
            puts "\n==============================================\n".green
            puts "Please enter your username: ".green
            puts "\n==============================================\n".green
            name = gets.chomp.to_s
            if users.map { |u| u["username"]}.include?(name)
                puts "\nPlease enter your password: ".green
                puts "\n==============================================\n".green
                pwd = gets.chomp
                if users.map { |u| u["password"]}.include?(pwd)
                puts "\n==============================================\n".green
                    puts "\n--- Welcome to our family ---\n".green
                    puts " 1 - Activities\n ".yellow
                    puts " 2 - Internet Searching\n".yellow
                    puts "\n==============================================\n".green
                    select = gets.chomp.to_i
                    if select == 1
                        puts "\n--- Welcome to our activities ---\n".yellow
                        puts "\n==============================================\n".green
                        puts "Do you want to join in the activity? yes / no\n".blue
                        act = gets.chomp.to_s
                        if  act == "yes" 
                            user = users.find { |user| user["username"] == name}
                            user[:doact] = act
                            users.delete_if { |user| user["username"] == name}
                            users.push(user)
                            File.write("people.json", JSON.dump(users))
                            p users.select { |user| user["doact"]}.map { |u| u["username"] }

                            puts "\nWe can't wait to see you !\n".yellow
                            puts "\n==============================================\n".green
                            puts "\nDo you want to continue ? yes / no\n".yellow
                            acty = gets.chomp.to_s
                            if  acty == "yes" || acty == "Yes" || acty == "y" || acty == "Y"
                                puts "\n--- Welcome back ---\n".yellow
                                puts "\n==============================================\n".green
                                next
                            elsif acty == "no" || acty == "No" || acty == "n" || acty == "N"
                                puts "\nHope to see you soon!\n".yellow
                                puts "\n==============================================\n".green
                                break
                            else
                                puts "\nIt's not in options, please try it again !\n".red
                                puts "\n==============================================\n".green
                                next
                            end
                        elsif act == "no" 
                            puts "\nHope you can join in us on next time !\n".yellow
                            puts "\n==============================================\n".green
                            puts "\nDo you want to continue ? yes / no\n".yellow
                            actn = gets.chomp.to_s
                            if  actn == "yes" || actn == "Yes" || actn == "y" || actn == "Y"
                                next
                                puts "\n--- Welcome back ---\n".yellow
                                puts "\n==============================================\n".green
                            elsif actn == "no" || actn == "No" || actn == "n" || actn == "N"
                                puts "\nHope to see you soon!\n".yellow
                                puts "\n==============================================\n".green
                                break
                            else
                                puts "\nIt's not in options, please try it again !\n".red
                                puts "\n==============================================\n".green
                                next
                            end
                        else
                            puts"\nIt's not in the options, please try it again!\n".red
                            puts "\n==============================================\n".green
                            next
                        end
                    elsif select == 2
                        puts "\n--- Welcome to Internet Searching ---".blue
                        puts "\n==============================================\n".green
                        user_search = ""
                        if ARGV.size == 0
                            puts "\nYou need to enter something to search for".yellow
                            puts "\nWhat would you like to search for?\n".yellow
                            puts "\n==============================================\n".green
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
                        puts "\nDo you want to continue ? yes / no\n".yellow
                            int = gets.chomp.to_s
                            if  int == "yes" || int == "Yes" || int == "y" || int == "Y"
                                next
                                puts "\n--- Welcome back ---\n".yellow
                                puts "\n==============================================\n".green
                            elsif int == "no" || int == "No" || int == "n" || int == "N"
                                puts "Hope to see you soon!"
                                puts "\n==============================================\n".green
                                break
                            else
                                puts "\nIt's not in options, please try it again !\n".red
                                puts "\n==============================================\n".green
                                next
                            end
                    else
                        puts "\nIt's not in options, please try it again !\n".red
                        puts "\n==============================================\n".green
                        next
                    end
                else
                    puts "\nPassword is incorrect, please try again! \n".red
                    puts "\n==============================================\n".green
                    next
                end
            else
                puts "\nIt's not a exsiting username, please try again !\n".red
                puts "\n==============================================\n".green
                next
            end

        elsif option == "3"
            puts "\n Welcome to Help System ! \n".blue
            puts "\n==============================================\n\n".green
            puts " 1- Regist New: Please flow the instruction and fill up the requirement.\n"
            puts " 2- Sign In: Please log in with your username and password first.you can have two options which they are Acitvities and Internet search, you can choose what you want.\n\n" 
            puts "\n==============================================\n\n".green
            puts "\n\nDo you want to continue ? yes / no\n".green
                int = gets.chomp.to_s
                if  int == "yes" || int == "Yes" || int == "y" || int == "Y"
                    next
                else
                    puts "\nSee you next time!\n".yellow
                    puts "\n==============================================\n\n".green
                    
                    break
                end    
        
        elsif option == "1"
           
            puts "\nPlease enter username:".green
            puts "\n==============================================\n".green
            username = gets.chomp
            usernames_array = users.map { |user| user["username"] }
            if usernames_array.include?(username)
            puts "#{username} is already in usernames array!".red
            next    
            end
            
            user[:username] = username
            puts "\nPlease enter your password:".green
            puts "\n==============================================\n".green
            pwd = gets.chomp
            puts "\nPlease enter your password again:".green
            puts "\n==============================================\n".green
            pwd2 = gets.chomp
            if pwd2 == pwd
                user[:password] = pwd
                puts "\nPlease enter your phone number: ".green
                puts "\n==============================================\n".green
                phone = gets.chomp.to_i
                user[:phone] = phone
                puts "\nPlease enter your email address: ".green
                puts "\n==============================================\n".green
                email = gets.chomp
                user[:email] = email
                users.push(user)
                
            else
                puts "\nRepeat password is incorrect, Please try again! \n".red
                puts "\n==============================================\n".green
                next
            end
            
            puts "\n\nDo you want continue ? yes / no\n".yellow
            puts "\n==============================================\n".green
            want = gets.chomp.to_s
            if want == "yes"
                puts "\n\nWelcome come back\n".yellow
                puts "\n==============================================\n".green
                next
            else
                break
            end
            
        else 
            puts "It's not include the options, Please try again!"
            puts "\n==============================================\n".green
            next
        end
        end
    
    # users.push(user)
    File.write("people.json", JSON.dump(users))
  end
end

main = Main.new
main.run