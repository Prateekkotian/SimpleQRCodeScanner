//
//  ProductViewController.swift
//  SimpleQRCodeScanner
//
//  Created by Prateek kumar on 10/30/17.
//  Copyright © 2017 Prateek kumar. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    var products = [ProductModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let product1 = ProductModel(title: "title1", subTitle: "subtitle1", imageUrl: "https://res.cloudinary.com/demo/image/upload/Sample.jpg")
        products.append(product1)
        let product2 = ProductModel(title: "title2", subTitle: "subtitle2", imageUrl: "https://i.ytimg.com/vi/PCwL3-hkKrg/maxresdefault.jpg")
        products.append(product2)
        let product3 = ProductModel(title: "title3", subTitle: "subtitle3", imageUrl: "https://cdn.tourradar.com/s3/tour/original/96588_fa01071d.jpg")
        products.append(product3)
        let product4 = ProductModel(title: "title4", subTitle: "subtitle4", imageUrl: "https://imagesvc.timeincapp.com/v3/mm/image?url=http%3A%2F%2Fcdn-image.myrecipes.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2F1606p126-vietnamese-pork-salad.jpg%3Fitok%3D5ZvymSan&w=700&q=85")
        products.append(product4)
        let product5 = ProductModel(title: "title5", subTitle: "subtitle5", imageUrl: "https://imagesvc.timeincapp.com/v3/mm/image?url=http%3A%2F%2Fcdn-image.myrecipes.com%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2Fvietnamese-style-pork-noodle-salad-ck.jpg%3Fitok%3DyhWl1IXm&w=700&q=85")
        products.append(product5)
    }
}


extension ProductViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProductTableViewCell.self)", for: indexPath) as! ProductTableViewCell
        let product = products[indexPath.row]
        cell.configureCell(title: product.title, subTitle: product.subTitle, imageUrlString: product.imageUrl)
        return cell
    }
}
