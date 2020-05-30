//
//  TodoListTableViewCell.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 30/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var todoLabel: UILabel!

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        switcher.isOn = false
        todoLabel.text = ""
    }
    
    func configCell(done: Bool, text: String) {
        
        switcher.isOn = done
        todoLabel.text = text
    }
}
