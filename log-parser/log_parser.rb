require 'date'

class LogParser
  FILE_NAME = "log.txt"

  def self.show_logs(level, date = nil)
    if date && !valid_date?(date)
      puts "Invalid date format. Use YYYY-MM-DD."
      return
    end

    load_logs.each do |line|
      if line.include?(level)
        puts line if date.nil? || line.include?(date)
      end
    end
  end

  def self.count_errors
    load_logs.count { |line| line.include?("ERROR") }
  end

  private

  def self.load_logs
    return [] unless File.exist?(FILE_NAME)
    File.readlines(FILE_NAME)
  end

  def self.valid_date?(date)
    if date.match?(/^\d{4}-\d{1,2}-\d{1,2}$/)
      begin
        Date.strptime(date, "%Y-%m-%d")
        return true
      rescue
        return false
      end
    else
      return false
    end
  end
end

puts "Use 'errors' to see the amount of errors. \nUse 'show <level> <date in form of YYYY-MM-DD>'."
loop do
  print("> ")
  input = gets.chomp.split

  case input[0]
  when "errors"
    puts "Your log file contains #{LogParser.count_errors} errors. \nTo see them use 'show ERROR'."
  when "show"
    if input[1] && input[2]
      LogParser.show_logs(input[1].upcase, input[2])
    elsif input[1]
      LogParser.show_logs(input[1].upcase)
    else
      puts "Wrong input"
    end
  when "exit"
    break
  else
    puts "Unknown command"
  end
end