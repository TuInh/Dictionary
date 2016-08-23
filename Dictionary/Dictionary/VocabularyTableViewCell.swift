//
//  VocabularyTableViewCell.swift
//  Dictitionary2
//
//  Created by Tu Inh Le on 8/22/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit

class VocabularyTableViewCell: UITableViewCell {

    // MARK : IBOutlet
    @IBOutlet var vietnameseLabel: UILabel!
    @IBOutlet var kanjiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set font for label
        kanjiLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        kanjiLabel.font = UIFont.boldSystemFontOfSize(kanjiLabel.font.pointSize)       
        vietnameseLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
