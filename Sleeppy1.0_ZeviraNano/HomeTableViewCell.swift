//
//  HomeTableViewCell.swift
//  Sleeppy1.0_ZeviraNano
//
//  Created by Zevira varies martan on 29/04/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var label1: UILabel!
    
    
    static let identifier = "HomeTableViewCell"
    static func nib()->UINib {
        return UINib(nibName: "HomeTableViewCell", bundle: nil)
    }
    
    public func configure(with title: String, imageName: String) {
        myLabelView.text =  title
        myImageView.image = UIImage(systemName: imageName)
    }
    
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myLabelView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
