class PhoneBook
  FILE_NAME = "numbers.txt"
  
  attr_reader :name, :number

  def initialize(name, number)
    @name = name
    @number = number
  end

  def self.add_phone_number(name, number)
    phone_numbers = load_phone_numbers
    phone_numbers << PhoneBook.new(name, number)
    save_phone_numbers(phone_numbers)
  end

  def self.remove_phone_number(name)
      phone_numbers = load_phone_numbers
      number_to_remove = find_contact(name)

      if number_to_remove
        phone_numbers.reject! { |phone_number| phone_number == number_to_remove }
        save_phone_numbers
        puts "#{name.capitalize()} removed succesffully!"
      else
        puts "No such phone number."
      end
  end

  def self.find_contact(name)
    phone_numbers = load_phone_numbers
    phone_numbers.find { |phone_number| phone_number.name == name}
  end

  def self.show_contact_list
    phone_numbers = load_phone_numbers
    if phone_numbers.empty?
      puts "No contacts yet."
    else
      phone_numbers.each_with_index do |phone_number, idx|
        puts "#{idx + 1}: #{phone_number.name} - #{phone_number.number}"
      end
    end
  end

  private

  def self.load_phone_numbers
    return [] unless File.exist?(FILE_NAME)

    File.readlines(FILE_NAME).map do |line|
      name, number = line.chomp.split(" | ", 2)
      PhoneBook.new(name, number) if name && number
    end.compact
  end

  def self.save_phone_numbers(phone_numbers)
    File.open(FILE_NAME, "w") do |file|
      phone_numbers.each { |phone_number| file.puts("#{phone_number.name} | #{phone_number.number}") }
    end
  end
end

puts "Welcome to phone book! \n Use 'show' to see all contacts. \n Use 'add' to add new contact. \n Use 'remove' to remove contact from your book. \n Use 'find' to find contact."
loop do
  print("> ")
  input = gets.chomp.downcase

  case input
  when "show"
    PhoneBook.show_contact_list()
  when "add"
    puts "Enter contact name:"
    name = gets.chomp.capitalize
    puts "Enter phone number:"
    phone_number = gets.chomp
    PhoneBook.add_phone_number(name, phone_number)
    puts "Contact added!"
  when "remove"
    puts "Enter contact name to remove:"
    name = gets.chomp
    PhoneBook.remove_phone_number(name)
  when "find"
    puts "Enter contact name to find:"
    name = gets.chomp.capitalize
    contact = PhoneBook.find_contact(name)

    if contact
      puts "Number: #{contact.number}"
    else
      puts "No such contact in the book"
    end
  when "exit"
    break
  end
end