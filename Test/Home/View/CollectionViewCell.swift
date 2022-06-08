//
//  CollectionViewCell.swift
//  Test
//
//  Created by Akshay on 07/06/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gifImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gifImageView.image = UIImage(named: "placeHolder")
    }
    func setContent(url: String) {
        if let url = URL(string: url) {
            gifImageView.setImage(from: url, placeholder: UIImage(named: "placeHolder"))
        }
    }

}
