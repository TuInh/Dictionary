//
//  DetailTableViewCell.swift
//  Dictitionary2
//
//  Created by le.thi.van.anh on 8/22/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    // MARK : IBOulet
    @IBOutlet weak var starUIImage: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var meaningTextField: UITextField!
    @IBOutlet weak var heightofTextField: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code for cell
        typeLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        typeLabel.font = UIFont.systemFontOfSize(typeLabel.font.pointSize*1.2)
        typeLabel.textColor = UIColor.orangeColor()
        
        meaningTextField.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        meaningTextField.font = UIFont.systemFontOfSize((meaningTextField.font?.pointSize)!/1.1)
        meaningTextField.borderStyle = UITextBorderStyle.None
        
        heightofTextField.constant = (meaningTextField.font?.pointSize)!
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
