//
//  TransactionTableViewCell.swift
//  BankApp
//
//  Created by Denis Loctier on 22/10/2022.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var transactionTypeLabel: UILabel!
    
    @IBOutlet weak var transactionSumLabel: UILabel!
        
    @IBOutlet weak var transactionDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
