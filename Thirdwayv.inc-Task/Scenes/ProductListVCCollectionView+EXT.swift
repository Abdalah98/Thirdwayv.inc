//
//  ProductListVCCollectionView+EXT.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 10/06/2022.
//

import Foundation
import UIKit

//MARK: - CollectionViewDataSource

extension ProductListVC :UICollectionViewDataSource {
    
    /// configure nib CollectionView
    func configureCollection(){
        if let layout = productListCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        let nib = UINib(nibName: Cell.productCell, bundle: nil)
        productListCollectionView.register(nib, forCellWithReuseIdentifier: Cell.productCell)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCell
    }
    
}

//MARK: - CollectionViewDelegate

extension ProductListVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.productCell , for: indexPath) as? ProductCell else{
            fatalError("Not found cell identifier")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.productCellViewModel = cellVM
        return cell
    }
    
    
    /// passing data  by prepare segue with animate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.productDetails(at: indexPath)
        productDetailsPopUpVC()
    }
    
    
    //MARK: - PopUpVC
    fileprivate func productDetailsPopUpVC() {

        let popOverVC = UIStoryboard(name: Main.productDetails, bundle: nil).instantiateViewController(withIdentifier: ViewController.productDetailsVC) as! ProductDetailsVC
            
            let product = self.viewModel.selectedProduct
            popOverVC.productDescription = product?.productDescription
            popOverVC.productPrice       = "\(product?.price ?? 0) $"
            popOverVC.productImageView   = product?.image.url
            
            self.addChild(popOverVC)
            popOverVC.view.frame = self.view.frame
            
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
    }
    
    //MARK: - ScrollingView
    //scrolled infinitely to load more products recall the service to get the same data retrieved before. So each scroll should add another  products
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            viewModel.fetchMoredata()
        }
    }
}

//MARK: - PinterestLayoutDelegate

extension ProductListVC: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.getCellViewModel(at: indexPath).height)
    }
    
}
