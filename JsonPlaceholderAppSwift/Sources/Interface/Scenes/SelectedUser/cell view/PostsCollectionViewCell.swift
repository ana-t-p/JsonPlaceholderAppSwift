//
//  PostsCollectionViewCell.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

class PostsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    func setPost(_ text: String) {
        
        postLabel.text = text
    }
}
