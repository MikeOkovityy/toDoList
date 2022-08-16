//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by artsiom on 11.08.22.
//

import UIKit

class AddTaskViewController: UIViewController {

    
    @IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var taskNameTextField: UITextField!

	// Замыкание для передачи данных https://swiftbook.ru/post/tutorials/pass-data/
	var clousure: ((ToDoModel) -> Void)?
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func setupDatePicker() {
        datePicker.minimumDate = Date()
    }
    
	@IBAction func addTask() {
		guard let text = taskNameTextField.text, text.count > 0 else { return }
		let toDoModel = ToDoModel(task: text, isDone: false)
		// Передаем данные в замыкание, для передачи назад
		clousure?(toDoModel)
		// Возвращаемся назад
		navigationController?.popViewController(animated: true)
	}


}
