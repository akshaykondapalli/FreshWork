//
//  HomeViewCell.swift
//  Test
//
//  Created by Akshay on 07/06/22.
//

import UIKit

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var favImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gifImageView.image = UIImage(named: "placeHolder")
        favImageView.image = UIImage(named: "noFav")
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setContent(url: String, isFav: Bool = false) {
        if let url = URL(string: url) {
            gifImageView.setImage(from: url, placeholder: UIImage(named: "placeHolder"))
        }
        favImageView.image = isFav ? UIImage(named: "fav") : UIImage(named: "noFav")
    }

}

extension UIImageView {

    func setImage(from url: URL, placeholder: UIImage? = nil) {
        image = placeholder
        ImageCache.shared.imageFor(url: url) { image in
            DispatchQueue.main.async {
            self.image = image
            }
        }
    }
}

class ImageCache {

    static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()
    var task = URLSessionDataTask()
    var session = URLSession.shared

    func imageFor(url: URL, completionHandler: @escaping (_ image: UIImage?) -> Void) {
            if let imageInCache = self.cache.object(forKey: url.absoluteString as NSString)  {
                completionHandler(imageInCache)
                return
            }

            self.task = self.session.dataTask(with: url) { data, response, error in

                if let error = error {
                    completionHandler(nil)
                    return
                }

                let image = UIImage(data: data!)

                self.cache.setObject(image ?? UIImage(), forKey: url.absoluteString as NSString)
                completionHandler(image)
                }

            self.task.resume()
    }
}

