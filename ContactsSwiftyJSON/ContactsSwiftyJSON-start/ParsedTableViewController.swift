//
//  ParsedTableViewController.swift
//  ContactsSwiftyJSON-start
//
//  Created by Kirill Timanovsky on 04.04.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class ParsedTableViewController: UIViewController {
    
    var contactsArray = [ContactModel]()
    
    
    @IBOutlet weak var parsingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.getJSONFromAPI {
            print("Data downloaded")
            self.parsingTableView.reloadData()
        }
    }

    func getJSONFromAPI(completion: @escaping GetComplete) {
        AF.request(apiURL, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { (apiResponse) in
            guard let unwrResponse = apiResponse.value else {
                return
            }
            let json = JSON(unwrResponse)
            print(json)
            
            for i in 0..<json.count {
                let contactValues = ContactModel(contactDictionary: json[i])
                self.contactsArray.append(contactValues)
            }
            
            completion()
            
        }
    }
}

extension ParsedTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = parsingTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = contactsArray[indexPath.row].name
        cell.detailTextLabel?.text = contactsArray[indexPath.row].species
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openDetailViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let unwrParsingRow = parsingTableView.indexPathForSelectedRow?.row,
              let unwrIndexPathForRow = parsingTableView.indexPathForSelectedRow else {
            return
        }
        
        if let destinationViewController = segue.destination as? DetailViewController {
            destinationViewController.contactsData = contactsArray[(unwrParsingRow)]
            parsingTableView.deselectRow(at: unwrIndexPathForRow, animated: true)
            
        
        }
    }
    
    
}
