//
//  ViewController.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 10/06/2022.
//
import UIKit

class ProductListVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    
    //MARK: - Properties
    ///  to select cell  when passing data
    var selectedProduct : Product?
    
    /// ActivityIndicator when call data i show loading Activity when i fetch data  it hidden or when something error it hide and show it data donloading
    let activity: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.style = .large
        aiv.color = .label
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    
    // binding with viewModel to fetch data when get
    lazy var viewModel: ProductListViewModel = {
        return  ProductListViewModel()
    }()

    
    //MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
    }
    
    
    /// activityView Hide
    //  activityView Hide when get data or found error
    fileprivate func stopActivity(){
        self.activity.stopAnimating()
        self.activity.hidesWhenStopped = true
    }
    
    
}

// MARK: - fetching data
extension ProductListVC {
    // fetch data
    /// fetch data when binding with Closure
    fileprivate  func initVM(){
        showAlert()
        updateLoadingStatus()
        reloadCollectionView()
        
        // add activity addSubview and show when loading data
        view.addSubview(activity)
        activity.fillSuperview()
        configureCollection()
        
       
    }
    
    
    ///  show Alert Closure : when get error or happen something show me error in Alert extension
    fileprivate func showAlert() {
        viewModel.showAlertClosure = {[weak self] in ()
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage  {
                    self?.showAlert(message)
                }
            }
        }
    }
    
    
    /// updateLoadingStatus: when call data i show loading Activity when i fetch all data  it hidden or when something error it hide and show it data downloading
    /// animate when collection show it
    fileprivate func  updateLoadingStatus() {
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.stopActivity()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productListCollectionView.alpha = 0.0
                    })
                case .loading:
                    self.activity.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productListCollectionView.alpha = 0.0
                    })
                case .populated:
                    self.stopActivity()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productListCollectionView.alpha = 1.0
                    })
                }
            }
        }
    }
    
    
    /// reloadCollectionViewClouser:  reload data when it comes to show in collection and fetch data
    fileprivate func  reloadCollectionView() {
        
        viewModel.reloadCollectionViewClouser = {[weak self] in ()
            DispatchQueue.main.async {
                self?.productListCollectionView.reloadData()
            }
        }
    }
    
}

