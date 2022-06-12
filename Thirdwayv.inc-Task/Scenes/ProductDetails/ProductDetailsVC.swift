//
//  ProductDetailsVC.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 10/06/2022.
//

import UIKit

class ProductDetailsVC: UIViewController {
    //MARK: - IBOutlet
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    //MARK: - Properties
    
    /// ver holding data image from  ProductVC and  download it and save in cache
    var productImageView : String?
    /// ver holding data price from  ProductVC
    var productPrice : String?
    /// ver holding data productDescription from  ProductVC
    var productDescription : String?
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    
    //MARK: - IBAction
    @IBAction func closePopUp(_ sender: AnyObject) {
        self.removeAnimate()
    }
    
    
    //MARK: - Private
  
    fileprivate func initView() {
        self.showAnimate()
        self.view.backgroundColor = UIColor.label.withAlphaComponent(0.8)
        bindingData()
    }
    
    // fetch data and binding with view
    fileprivate func bindingData() {
        productPriceLabel.text = productPrice
        productDescriptionLabel.text = productDescription
        if let url = productImageView {
            self.productImage.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "no_image_placeholder"))
        }
    }
    
    // to show animate when popup
    fileprivate func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    
    // to remove animate when close

    fileprivate  func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        })
    }
}

