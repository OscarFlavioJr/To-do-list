require 'json'

todo_file = 'todo_list.json'

def load_tasks(file)
  File.exist?(file) ? JSON.parse(File.read(file)) : []
end

def save_tasks(file, tasks)
  File.write(file, JSON.pretty_generate(tasks))
end

def add_task(file, task)
  tasks = load_tasks(file)
  tasks << { "id" => tasks.size + 1, "task" => task }
  save_tasks(file, tasks)
  puts "Tarefa adicionada: #{task}"
end

def list_tasks(file)
  tasks = load_tasks(file)
  if tasks.empty?
    puts "Nenhuma tarefa encontrada."
  else
    puts "Lista de Tarefas:"
    tasks.each { |t| puts "#{t['id']}. #{t['task']}" }
  end
end

def remove_task(file, task_id)
  tasks = load_tasks(file)
  tasks.reject! { |t| t["id"] == task_id }
  tasks.each_with_index { |t, index| t["id"] = index + 1 }
  save_tasks(file, tasks)
  puts "Tarefa removida: ##{task_id}"
end

loop do
  puts "\nEscolha uma opção:"
  puts "1. Adicionar Tarefa"
  puts "2. Listar Tarefas"
  puts "3. Remover Tarefa"
  puts "4. Sair"
  print "Opção: "
  opcao = gets.chomp.to_i

  case opcao
  when 1
    print "Digite a nova tarefa: "
    task = gets.chomp
    add_task(todo_file, task)
  when 2
    list_tasks(todo_file)
  when 3
    print "Digite o ID da tarefa a remover: "
    task_id = gets.chomp.to_i
    remove_task(todo_file, task_id)
  when 4
    puts "Saindo..."
    break
  else
    puts "Opção inválida!"
  end
end
