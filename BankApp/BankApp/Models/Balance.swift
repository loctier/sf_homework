//
//  Balance.swift
//  BankApp
//
//  Created by Denis Loctier on 22/10/2022.
//

import Foundation
import RealmSwift
// import UIKit

class Balance: Object {
    @objc dynamic var bankAccount: Double = 0.0
    @objc dynamic var phone: Double = 0.0
    @objc dynamic var timeStamp: Date = Date.now
        
    func loadBankAccountBalance() -> Double {
        let realm = try! Realm()
        let balanceRecords = realm.objects(Balance.self)
        if balanceRecords.count > 0 {
            let bankAccountBalance = balanceRecords.last!.bankAccount
            return bankAccountBalance  } else {
                return 0.0
            }
    }
    
    func loadPhoneBalance() -> Double {
        let realm = try! Realm()
        let balanceRecords = realm.objects(Balance.self)
        if balanceRecords.count > 0 {
            let phoneBalance = balanceRecords.last!.phone
            return phoneBalance  } else {
                return 0.0
            }
    }
    
    func save(bankAccount: Double, phone: Double){
        // let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm()
        try! realm.write {
            let balance = Balance()
            let timeStamp = Date.now
            balance.timeStamp = timeStamp
            balance.bankAccount = bankAccount
            balance.phone = phone
            realm.add(balance)
        }
    }
    
    
    
    
}
