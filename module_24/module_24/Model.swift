//
//  model.swift
//  module_24
//
//  Created by Denis Loctier on 01/09/2022.
//

// Модель для хранения и операций с данными приложения


import Foundation
import UIKit

// Задачи состоят из описания и флага выполненности

class Task {
    var description: String
    var completed: Bool
    init(description: String, completed: Bool) {
        self.description = description
        self.completed = completed
    }
}

// Модель состоит из массива задач (несколько предварительно созданных задач создаются для демонстрации)

class Model {
    var tasks: [Task] = [
        Task(description: "Посмотри на часы", completed: true),
        Task(description: "Посмотри на портрет на стене", completed: false),
        Task(description: "Прислушайся — там, за окном, ты услышишь наш смех", completed: false),
        Task(description: "Закрой за мной дверь, я ухожу", completed: false)
    ]
    
    // Вычисляемое свойство, показываюшее число невыполненных задач
    
    var uncompleted: Int {
        get {
            var outstanding: Int = 0
            for task in tasks {
                if !task.completed { outstanding += 1}
            }
         return outstanding
        }
    }
    
// Метод для выставления/снятия флага выполненности
    
    func toggleCompleted(taskNumber: Int) {
        tasks[taskNumber].completed.toggle()
    }

}
