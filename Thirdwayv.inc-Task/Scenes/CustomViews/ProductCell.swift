//
//  ProductCell.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 10/06/2022.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDetailsLabel: UILabel!
    
    /// The var  PorductCellViewModel read data from it and pass it from product vc
    var productCellViewModel:PorductCellViewModel?{
        didSet{
            productPriceLabel.text = "\(productCellViewModel?.price ?? 0) $"
            productDetailsLabel.text = productCellViewModel?.productDescription
            
            /// download image from  api and  save in cache
            if let url = productCellViewModel?.image {
                self.productImage.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "no_image_placeholder"))
            }
        }
    }
}
