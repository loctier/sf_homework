//
//  DetailViewController.swift
//  ContactsSwiftyJSON-start
//
//  Created by Kirill Timanovsky on 04.04.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var speciesLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var originLabel: UILabel!
    
    var contactsData: ContactModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = contactsData.name
        statusLabel.text = contactsData.status
        speciesLabel.text = contactsData.species
        genderLabel.text = contactsData.gender
        originLabel.text = contactsData.origin
        
    

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
