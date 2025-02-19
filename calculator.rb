puts "Input expression. To exit type 'exit'."
loop do
    expression = gets.chomp
    if expression.match?(/^(?=.*[+\-*\/])(?=.*\d)[\d+\-*\/.\s]+[\d.]+$/)
      begin
        result = eval(expression)
        puts "Result: #{result}"
      rescue ZeroDivisionError
        puts "Division by zero is not possible!"
      rescue StandardError
        puts "Invalid input!"
      end
    elsif expression.downcase == "exit"
      break;
    else
      puts "Invalid characters in expression!"
    end
end