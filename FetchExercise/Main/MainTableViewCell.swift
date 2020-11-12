//
//  MainTableViewCell.swift
//  FetchExercise
//
//  Created by Admin on 11/12/20.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listId: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
