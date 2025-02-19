class Task
  FILE_NAME = "tasks.txt"
  attr_reader :id, :name, :description

  def initialize(id, name, description)
    @id = id
    @name = name
    @description = description
  end

  def self.add_task(id, name, description)
    tasks = load_tasks
    tasks << Task.new(id, name, description)
    save_tasks(tasks)
  end

  def self.remove_task(task_id)
    tasks = load_tasks
    task_to_remove = tasks.find { |task| task.id == task_id}

    if task_to_remove
      tasks.reject! { |task| task == task_to_remove }
      save_tasks(tasks)
      puts "Task with id:'#{task_id}' removed successfully!"
    else
      puts "No such task exists in the list."
    end
  end

  def self.show_tasks
    tasks = load_tasks
    if tasks.empty?
      puts "No current tasks."
    else
      tasks.each do |task|
        puts "#{task.id}: #{task.name} - #{task.description} \n"
      end
    end
  end

  private

  def self.load_tasks
    return [] unless File.exist?(FILE_NAME)

    File.readlines(FILE_NAME).map do |line|
      id, name, description = line.chomp.split(" | ", 3)
      Task.new(id, name, description) if id && name && description
    end.compact
  end

  def self.save_tasks(tasks)
    File.open(FILE_NAME, "w") do |file|
      tasks.each { |task| file.puts("#{task.id} | #{task.name} | #{task.description}") }
    end
  end
end

task_id = 0
puts "Welcome to To-Do List! \n Use 'show' to see all current tasks. \n Use 'add' to add new task. \n Use 'remove' to remove existing task."
loop do
  print("> ")
  input = gets.chomp.downcase

  case input
  when "show"
    Task.show_tasks
  when "add"
    task_id += 1
    print "Enter task name: "
    name = gets.chomp
    print "Enter task description: "
    description = gets.chomp
    Task.add_task(task_id, name, description)
  when "remove"
    print "Enter task id to remove: "
    name = gets.chomp
    Task.remove_task(name)
  when "exit"
    break
  else
    puts "Invalid command! Try again."
  end
end