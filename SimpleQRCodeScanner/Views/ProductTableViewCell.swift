//
//  ProductTableViewCell.swift
//  SimpleQRCodeScanner
//
//  Created by Prateek kumar on 10/30/17.
//  Copyright © 2017 Prateek kumar. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func configureCell(title: String, subTitle: String, imageUrlString: String) {
        titileLabel.text = title
        subTitleLabel.text = subTitle
        self.loadImage(imageUrlString: imageUrlString , completion: { [weak self] isLoaded, image in
            DispatchQueue.main.async {
                self?.backgroundImageView.image = image
            }
        })
    }
    
    
    func loadImage(imageUrlString: String, completion: @escaping (_ isLoaded: Bool, _ image: UIImage) -> Void) {
        guard let imageUrl = URL(string: imageUrlString) else { return }
        
        let request = URLRequest(url: imageUrl, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: TimeInterval(20))
        let urlSession = URLSession.shared
        urlSession.dataTask(with: request) { (responseData, urlResponse, error) in
            print(error?.localizedDescription ?? "")
            guard urlResponse != nil, let imageData = responseData else {
                return
            }
            guard let image = UIImage(data: imageData) else { return }
            completion(true, image)
            }.resume()
    }

}
