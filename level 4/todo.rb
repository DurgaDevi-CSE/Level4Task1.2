require "active_record"
require "./connect_db.rb"
require "colorize"

class Todo < ActiveRecord::Base
  def due_today?
    last_date == Date.today
  end
  def self.past_due
    where("last_date < ?", Date.today)
  end

  def self.today_due
    where("last_date = ?", Date.today)
    where(last_date: Date.today)
  end

  def self.upcoming_due
    where("last_date > ?", Date.today)
  end
  def self.show_list
    puts "My Todo-list\n\n".bold.blue.on_white.underline
    puts "Overdue\n".red.bold
    puts past_due.map { |todo| todo.to_visual_text }
    puts "\n\n"
    puts "Due Today\n".yellow.bold
    puts today_due.map { |todo| todo.to_visual_text }
    puts "\n\n"
    puts "Due Later\n".green.bold
    puts upcoming_due.map { |todo| todo.to_visual_text }
    puts "\n\n"
  end

  def self.add_task(todo_details)
    Todo.create!(todo_description: todo_details[:todo_text], last_date: Date.today + todo_details[:due_in_days], iscompleted: false)
  end

  def self.mark_as_complete!(row_id)
    todo.iscompleted = true
    todo = Todo.find(row_id)
    todo.save
    todo
  end

  def to_visual_text
    display_status = iscompleted ? "[X]" : "[ ]"
    display_date = last_date
    return "#{id}. #{display_status}	 #{todo_description}	 #{display_date}"
  def self.add_task(todo_details)
    create!(todo_description: todo_details[:todo_text], last_date: Date.today + todo_details[:due_in_days], iscompleted: false)
  end

  def self.to_displayable_list
    @todos.map { |todo|  todo.to_visual_text }
  end
  def self.mark_as_complete(todo_id)
    todo_for_completion = find(todo_id)
    todo_for_completion.iscompleted = true
    todo_for_completion.save
    return todo_for_completion
  end
end
end 