//
//  TransactionViewController.swift
//  BankApp
//
//  Created by Denis Loctier on 22/10/2022.
//

import UIKit

class TransactionViewController: UIViewController {
    
    var transactionType:String = "withdrawCash"
    
    var topMargin = 0.0
    
    @IBOutlet weak var transactionTitleLabel: UILabel!
    
    @IBOutlet weak var sumTextField: UITextField!
    
    @IBOutlet weak var transactionOKButton: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func updateViewConstraints() {
        
        self.view.frame.origin.y = topMargin
        self.view.layer.cornerRadius = 10
        
        super.updateViewConstraints()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch transactionType {
        case "depositCash":
            transactionTitleLabel.text = "Внести наличные"
            transactionOKButton.setTitle("Положить на счёт", for: .normal)
        case "withdrawCash":
            transactionTitleLabel.text = "Снять наличные"
            transactionOKButton.setTitle("Снять со счёта", for: .normal)
        case "topUpPhone":
            transactionTitleLabel.text = "Пополнить баланс телефона"
            transactionOKButton.setTitle("Перевести со счёта", for: .normal)
        default:
            return
        }
        
    }
        
    
    @IBAction func transactionOKButtonAction(_ sender: UIButton) {
        
        // Значение не введено
        if sumTextField.text == "" {
            return
        }
        
        // Пользователь использовал запятую в десятичной дроби
        let enteredSum = sumTextField.text!.replacingOccurrences(of: ",", with: ".")
        
        guard let sum = Double(enteredSum) else {
            // Введённое значение не соответствует типу Double
            
               let defaultAction = UIAlertAction(title: "OK",
                                    style: .default) { (action) in
                   return
               }
               let alert = UIAlertController(title: "Некорректный ввод",
                     message: "Пожалуйста, введите сумму транзакции цифрами",
                     preferredStyle: .alert)
               alert.addAction(defaultAction)
        
                    
               self.present(alert, animated: true) {
               }
            
            return
        }
        
        guard sum > 0 else {
            // Введено отрицательное значение
            
               let defaultAction = UIAlertAction(title: "OK",
                                    style: .default) { (action) in
                   return
               }
               let alert = UIAlertController(title: "Некорректный ввод",
                     message: "Сумма транзакции должна быть положительной",
                     preferredStyle: .alert)
               alert.addAction(defaultAction)
            
               self.present(alert, animated: true) {
               }
            
            return
        }
        
        
        var bankAccountBalance = Balance().loadBankAccountBalance()
        var phoneBalance = Balance().loadPhoneBalance()
        
        // Две из трёх операций могут завершиться с отрицательным балансом на счету. По условиям задания можно проверить согласие пользователя на овердрафт или вообще запретить уходить в минус. С учётом нынешней экономической ситуации давайте запретим пользователю уходить в минус
        
        if (transactionType == "withdrawCash" || transactionType == "topUpPhone") && (bankAccountBalance - sum < 0) {

            let defaultAction = UIAlertAction(title: "OK",
                                 style: .default) { (action) in
                return
            }
            // Create and configure the alert controller.
            let alert = UIAlertController(title: "Овердрафт не разрешён",
                  message: "После выполнения транзакции ваш банковский счёт ушёл бы в минус (\(bankAccountBalance - sum) руб.)\nОстаток на счету должен быть положительным, поэтому выполнить такую операцию невозможно.",
                  preferredStyle: .alert)
            alert.addAction(defaultAction)
                      
            self.present(alert, animated: true) {
            }
         
         return
            
        }
        
        // Выполним операцию
        
        switch transactionType {
        case "depositCash":
            bankAccountBalance += sum
            
        case "withdrawCash":
            bankAccountBalance -= sum
                        
        case "topUpPhone":
            bankAccountBalance -= sum
            phoneBalance += sum
            
        default:
            return
        }
        
        Balance().save(bankAccount: bankAccountBalance, phone: phoneBalance)
        Transaction().append(transactionType: transactionType, sum: sum)
                
        performSegue(withIdentifier: "myUnwind", sender: self)
                
    }
}
