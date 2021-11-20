require "./connect_db.rb"
require "./todo.rb"
connect_db!
Todo.show_list
puts "Which todo list do you want to mark as complete? (Provide #): "
todo_i = gets.strip.to_i

todo = Todo.mark_as_complete!(todo_i)

puts todo.to_displayable_string 
puts todo.to_displayable_string