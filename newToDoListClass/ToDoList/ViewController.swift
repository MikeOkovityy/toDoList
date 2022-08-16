//
//  ViewController.swift
//  ToDoList
//
//  Created by artsiom on 9.08.22.
//

import UIKit

class ViewController: UIViewController {
	
	var tasks = [
		ToDoModel(task: "Buy bread", isDone: false),
		ToDoModel(task: "Go for a walk", isDone: false),
		ToDoModel(task: "Work 9 hours", isDone: false),
		ToDoModel(task: "Call mom", isDone: false)
	]

    
    
    var allTasks: [[ToDoModel]] = [[ToDoModel]]
    
    
    
    
	@IBOutlet weak var tableView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableView()
	}

	func setupTableView() {
		tableView.dataSource = self
		tableView.delegate = self
        tableView.sele
		let toDoCell = UINib(nibName: "ToDoCell", bundle: nil)
		tableView.register(toDoCell, forCellReuseIdentifier: "todocell")

		// Разрешаем выделение(нажатие) во время редактирования
		tableView.allowsSelectionDuringEditing = true
		
	}

	@IBAction func addButtonPressed(_ sender: Any) {
		// Получаем ссылку на сториборд
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		// Получаем ViewController по его ID и приводим к типу AddTaskViewController
		guard let destination = storyboard.instantiateViewController(identifier: "AddTaskViewController") as? AddTaskViewController else { return }

		destination.clousure = { model in
			self.tasks.append(model)
			// Обновление данных в таблице
			self.tableView.reloadData()
		}
		// Переходим на новый экран
		navigationController?.pushViewController(destination, animated: true)
	}

	@IBAction func switchEditingMode(_ sender: Any) {
		// Включаем/Выключаем режим редактирования
		tableView.isEditing.toggle() // функция toggle() меняет переменную типа Bool на противоположное значение, true -> false, false -> true
	}
}

extension ViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tasks.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "todocell", for: indexPath) as? ToDoCell
		else {
			return UITableViewCell()
		}
		cell.setup(task: tasks[indexPath.row])
        cell.selectionStyle = .none
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}

	// REORDER
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return .none
	}
	
	func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
		return false
	}
	 
}

extension ViewController: UITableViewDelegate {
	
	// Метод отвечающий за нажатие за ячейку
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 { return }
        
        var doneTask = allTasks[indexPath.section]
        
		tasks[indexPath.row].isDone = true
		tableView.reloadData()
	}
	
	
	// REORDER
	
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		// Достаем объект
        var movedCell = allTasks[sourceIndexPath.section][sourceIndexPath.row]
        
        if sourceIndexPath.section != destinationIndexPath.section { movedCell.isDone.toggle()
		// Удаляем из массива
            allTasks[sourceIndexPath.section].remove(at:[sourceIndexPath.row]
		// Вставляем на новую позицию
                                                    allTasks[destinationIndexPath.section].insert(movedCell, at: destinationIndexPath.row)
        
        tableView.reloadData()
	}


	// TAP
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//	}


	func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		
		let undoneAction = UIContextualAction(style: .normal, title: "Undone") { _, _, completion in
            
			self.tasks[indexPath.row].isDone = false
            let  unDoneTask = self.allTasks[indexPath.section][indexPath.row]
			tableView.reloadData()
			completion(true)
		}

		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
			self.allTasks[indexPath]
			tableView.reloadData()
			completion(true)
		}

		undoneAction.backgroundColor = .systemBlue
		deleteAction.backgroundColor = .systemRed

        }
    
}

return UISwipeActionsConfiguration(actions: IndexPath.section == 0 [deleteAction]) : [deletAction, undonAction])


	}
