//
//  ViewController.swift
//  BankApp
//
//  Created by Denis Loctier on 22/10/2022.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var balanceView: UIView!
    @IBOutlet weak var transactionsTableView: UITableView!
    @IBOutlet weak var bankAccountBalanceLabel: UILabel!
    @IBOutlet weak var phoneBalanceLabel: UILabel!
    
    let transactionDescription = ["withdrawCash": "Снятие наличных",
                                 "depositCash": "Внесение наличных",
                                  "topUpPhone": "Пополнение телефона"]
    
    // Загрузка списка транзакций
    
    var bankAccountBalance: Double = 0.0
    var phoneBalance: Double = 0.0
        
    let currencyFormatter = NumberFormatter()
    
    let dateFormatter = DateFormatter()
    
    
    var transactions: [Transaction] = []
    var debits: [Transaction] = []
    var credits: [Transaction] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Оформление экрана и настройка показа денежных значений и дат

        balanceView.layer.cornerRadius = 10
        transactionsTableView.layer.cornerRadius = 10

        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "ru_RU")

        dateFormatter.dateFormat = "d MMM YY, HH:mm"
        
        // Настройка таблицы банковских операций
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        
        let nib = UINib(nibName: "TransactionTableViewCell",bundle: nil)
        transactionsTableView.register(nib, forCellReuseIdentifier: "TransactionTableViewCell")
       
        // Загрузка текущего баланса банковского счёта и телефона, обновление соответствующих полей на экране
        
        
        refresh()
        
    }
    
    func refresh() {
                
        bankAccountBalance = Balance().loadBankAccountBalance()
        phoneBalance = Balance().loadPhoneBalance()
        bankAccountBalanceLabel.text = currencyFormatter.string(for: bankAccountBalance)
        phoneBalanceLabel.text = currencyFormatter.string(for: phoneBalance)
        
        transactions = Transaction().load()
        
        debits.removeAll()
        credits.removeAll()
        
        for transaction in transactions {
            switch transaction.transactionType {
            case "depositCash":
                credits.append(transaction)
            case "withdrawCash":
                debits.append(transaction)
            case "topUpPhone":
                debits.append(transaction)
            default:
                return
            }
            
            credits.sort(by: { $0.timeStamp > $1.timeStamp })
            debits.sort(by: { $0.timeStamp > $1.timeStamp })
            
        }
        
        transactionsTableView.reloadData()
        
    }
    
    @IBAction func depositCashButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func withdrawCashButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func topUpPhoneButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue) {
        refresh()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case "depositCashSegue":
            if let nextViewController = segue.destination as? TransactionViewController {
                nextViewController.transactionType = "depositCash"
                nextViewController.topMargin = balanceView.frame.maxY+50                
            }
            
        case "withdrawCashSegue":
            if let nextViewController = segue.destination as? TransactionViewController {
                nextViewController.transactionType = "withdrawCash"
                nextViewController.topMargin = balanceView.frame.maxY+50
            }
            
        case "topUpPhoneSegue":
            if let nextViewController = segue.destination as? TransactionViewController {
                nextViewController.transactionType = "topUpPhone"
                nextViewController.topMargin = balanceView.frame.maxY+50
            }
        default:
            return
        }
    }

    
    
    // MARK: Функции UITableView
            
    let sections = ["Снятие со счёта", "Пополнение счёта"]
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (section == 0) {
            return debits.count
        } else {
            return credits.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath)  as! TransactionTableViewCell
        if (indexPath.section == 0) {
            cell.transactionTypeLabel.text = transactionDescription[debits[indexPath.row].transactionType]
            cell.transactionSumLabel.text = currencyFormatter.string(for: debits[indexPath.row].sum)
            
            // Convert Date to String
            cell.transactionDateLabel.text = dateFormatter.string(from: debits[indexPath.row].timeStamp)
            
        } else {
            cell.transactionTypeLabel.text = transactionDescription[credits[indexPath.row].transactionType]
            cell.transactionSumLabel.text = currencyFormatter.string(for: credits[indexPath.row].sum)
            // cell.transactionDateLabel.text = String(credits[indexPath.row].timeStamp)
        }
        
        return cell
    }

    
}
