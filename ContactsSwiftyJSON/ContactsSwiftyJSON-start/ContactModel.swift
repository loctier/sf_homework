//
//  ContactModel.swift
//  ContactsSwiftyJSON-start
//
//  Created by Denis Loctier on 23/12/2022.
//

import Foundation
import SwiftyJSON
import Alamofire

class ContactModel {
    var id: String
    var name: String
    var status: String
    var species: String
    var gender: String
    var origin: String
    
    init(contactDictionary: JSON) {
        self.id = contactDictionary["id"].stringValue
        self.name = contactDictionary["name"].stringValue
        self.status = contactDictionary["status"].stringValue
        self.species = contactDictionary["species"].stringValue
        self.gender = contactDictionary["gender"].stringValue
        self.origin = contactDictionary["origin"].stringValue
    }

}
