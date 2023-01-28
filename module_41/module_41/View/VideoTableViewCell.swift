//
//  VideoTableViewCell.swift
//  module_41
//
//  Created by Denis Loctier on 28/01/2023.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.image = nil
     
    }
    
}
