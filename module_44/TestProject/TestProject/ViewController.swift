//
//  ViewController.swift
//  TestProject
//
//  Created by SF on 01.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        users.append(User(firstName: "Петров",
                          lastName: "Петр",
                          bio: "Люблю SF",
                          city: "Москва",
                          friends: [User(firstName: "Иванов",
                                         lastName: "Иван",
                                         bio: "",
                                         city: "Москва",
                                         friends: [User(firstName: "Петров",
                                                        lastName: "Петр",
                                                        bio: "Люблю SF",
                                                        city: "Москва",
                                                        friends: [User(firstName: "Иванов",
                                                                       lastName: "Иван",
                                                                       bio: "",
                                                                       city: "Москва",
                                                                       friends: [],
                                                                       isClosed: true)],
                                                        isClosed: false)],
                                         isClosed: true),
                                    User(firstName: "Сергеев",
                                                   lastName: "Сергей",
                                                   bio: "Люблю swift",
                                                   city: "Москва",
                                                   friends: [User(firstName: "Петров",
                                                                  lastName: "Петр",
                                                                  bio: "Люблю SF",
                                                                  city: "Москва",
                                                                  friends: [User(firstName: "Иванов",
                                                                                 lastName: "Иван",
                                                                                 bio: "",
                                                                                 city: "Москва",
                                                                                 friends: [],
                                                                                 isClosed: true)],
                                                                  isClosed: false)],
                                                   isClosed: true)],
                          isClosed: false))
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let displayVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        displayVC.profile = .init(fullName: users[indexPath.row].firstName + " " + users[indexPath.row].lastName,
                                  city: users[indexPath.row].city,
                                  friends: users[indexPath.row].friends,
                                  isClosedPage: users[indexPath.row].isClosed)
        present(displayVC, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].firstName + " " + users[indexPath.row].lastName
        cell.textLabel?.accessibilityIdentifier = "\(indexPath.row)"
        return cell
    }
}
