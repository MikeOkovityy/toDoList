//
//  ToDoModel.swift
//  ToDoList
//
//  Created by artsiom on 9.08.22.
//

import Foundation

struct ToDoModel {
	let task: String
	var isDone: Bool
    let deadLineDate: Date()
    
	init(task: String, isDone: Bool) {
		self.task = task
		self.isDone = isDone
        self.deadLineDate = deadLineDate
	}
}
