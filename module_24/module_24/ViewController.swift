//
//  ViewController.swift
//  module_24
//
//  Created by Denis Loctier on 01/09/2022.
//

// View и контроллер

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let model = Model()
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // View создаётся программно, без storyboard
        
        let screenWidth = self.view.bounds.width
        
        // Шапка над таблицей
        
        let headerHeight = 150
        let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(screenWidth), height: headerHeight))
        header.backgroundColor = .cyan
        
        // Заголовок в шапке
        
        let headerTitle = UILabel(frame: CGRect(x: 20.0, y: 60.0, width: screenWidth/1.5, height: 100))
        headerTitle.font = UIFont.boldSystemFont(ofSize: 40.0)
        headerTitle.text = "To do"
        header.addSubview(headerTitle)
        
        // Кнопка добавления задачи в шапке
        
        let addButton = UIButton(frame: CGRect(x: screenWidth-50, y: 80, width: 40, height: 70))
        let headerImageConfiguration = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold, scale: .large)
        addButton.setImage(UIImage(systemName: "plus", withConfiguration: headerImageConfiguration), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        header.addSubview(addButton)
        
        // Выставляем шапку на вид, настраиваем и выставляем на вид

        self.view.addSubview(header)

        // Под шапкой создаём таблицу с задачами
        
        tableView = UITableView(frame: CGRect(x: 0, y: header.frame.height, width: self.view.bounds.width, height: self.view.bounds.height-header.frame.height), style: .plain)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }

    // При нажатии на кнопку добавления задачи появляется диалоговое окно с полем для ввода
    
    @objc
    func addButtonAction() {
        let alert = UIAlertController(title: "", message: "Add task", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.text = ""
            textField.placeholder = "Enter a new task"
        })
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (updateAction) in
            let newTask = Task(description: alert.textFields!.first!.text!, completed: false)
            // Новая задача добавляется в массив модели
            self.model.tasks.append(newTask)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: false)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Заголовок секции может показывать простую статистику задач
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Задач: \(model.tasks.count), из них невыполненных: \(model.uncompleted)"
    }
    
    // Размер таблицы определятся размером массива в модели
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return model.tasks.count
        
    }
    
    // Ячейки с задачами
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        var content = cell.defaultContentConfiguration()
        
        // Индикатор выполненности задачи — пустой или закрашенный круг, как в приложении Apple Reminders
        
        content.image = model.tasks[indexPath.row].completed ? UIImage(systemName: "circle.inset.filled") : UIImage(systemName: "circle")
        content.text = model.tasks[indexPath.row].description
        
        cell.contentConfiguration = content

        // Уберём закрашивание выбранной ячейки, иначе некрасиво
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    // Касание ячейки ставит или снимает флаг выполненности задачи в модели и обновляет вид
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.toggleCompleted(taskNumber: indexPath.row)
        tableView.reloadData()
    }
    

    // Активируем управление ячейками при помощи свайпов вправо или влево
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Свайп вправо открывает кнопку редактирования задачи
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->   UISwipeActionsConfiguration? {
        
        let title = NSLocalizedString("Edit", comment: "Edit")
        
        let action = UIContextualAction(style: .normal, title: title,
                                        handler: { (action, view, completionHandler) in
            
            // Показать диалоговое окно для редактирования текста задачи, который берётся из модели
            
            let alert = UIAlertController(title: "", message: "Edit task", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                textField.text = self.model.tasks[indexPath.row].description
            })
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                
                // Обновление модели
                self.model.tasks[indexPath.row].description = alert.textFields!.first!.text!
                
                // Обновление вида
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: false)
            
            completionHandler(true)
        })
        
        action.backgroundColor = .systemBlue
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    // Свайп влево открывает кнопку удаления задачи
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->   UISwipeActionsConfiguration? {
        
        let title = NSLocalizedString("Delete", comment: "Delete")
        
        let action = UIContextualAction(style: .normal, title: title,
                                        handler: { (action, view, completionHandler) in
            // Обновление модели
            self.model.tasks.remove(at: indexPath.row)
            // Обновление вида
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()

            completionHandler(true)
        })
        
        action.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}

