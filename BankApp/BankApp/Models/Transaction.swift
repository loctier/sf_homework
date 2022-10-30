//
//  Transaction.swift
//  BankApp
//
//  Created by Denis Loctier on 22/10/2022.
//

import Foundation
import RealmSwift
// import UIKit

class Transaction: Object {
    @objc dynamic var transactionType: String = ""
    @objc dynamic var timeStamp: Date = Date()
    @objc dynamic var sum: Double = 0.0
    
    func load() -> [Transaction] {
        
        let realm = try! Realm()
        let transactionRecords = realm.objects(Transaction.self)

        if transactionRecords.count > 0 {
            return Array(transactionRecords) } else {
                return []
            }
    }
    
    func append(transactionType: String, sum: Double){
        let realm = try! Realm()
        try! realm.write {
            let transaction = Transaction()
            transaction.timeStamp = Date.now
            transaction.transactionType = transactionType
            transaction.sum = sum
            realm.add(transaction)
        }
    }
    
}
