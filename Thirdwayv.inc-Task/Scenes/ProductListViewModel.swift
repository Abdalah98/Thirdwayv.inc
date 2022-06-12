//
//  ProductViewModel.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 10/06/2022.
//

import Foundation
/// ProductListViewModel Updates the model from view inputs and updates views from model outputs.
class ProductListViewModel  {
    
    //MARK: - Properties
    
    var fileManager: ProductFileManager?

    /// i  do  ApiServiceProtocol  to Dependency Injection
    let apiService : ApiServiceProtocol
    var selectedProduct: Product?
    
    
    /// product is array of DataSource to append data it
    private  var product = [Product](){
        didSet{
        self.startCaching()
            self.reloadCollectionViewClouser?()

          }
    }
    
  
    
    /// The cellViewModel in which I put the data  i get it from json and put in cell when data isready it call reloadCollectionViewClouser
    private var cellViewModel : [PorductCellViewModel] = [PorductCellViewModel](){
        didSet{
            self.reloadCollectionViewClouser?()
        }
    }
    
    /// callback for interfaces
    var reloadCollectionViewClouser :(()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    
    //MARK: - init
    
    /// i  do init to easy mocking   ApiServiceProtocol  to Dependency Injection
    /// - Parameter apiService: ApiServiceProtocol  to Dependency Injection
    init(apiService : ApiServiceProtocol = ApiService()) {
        self.apiService = apiService
        fileManager = ProductFileManager()
        NotificationCenter.default.addObserver(self,selector: #selector(statusManager),name: .flagsChanged,object: nil)

    }
 
    
    /// Update User Interface if has connection or not has connection networking
    /// - Parameter notification: notification center
    @objc func statusManager(_ notification: Notification) {
            updateUserInterface()
    }
    
    /// return number count of cell
    var numberOfCell :Int {
        return cellViewModel.count
    }
    
    
    ///  base of loading view
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    
    /// alertMessage  put the error in it if get error from api i  put it and show in Alert
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    
    //MARK: - fetchData
    
    /// once call it initFetchData in viewController the start state loading
    /// if get error change state to error and hide loading and show Alert
    /// and get data and make process
    func initFetchProductData(){
        state = .loading
        apiService.getProductList(){[weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let response):
                
                self.processFetchedProduct(products: response)
                self.state = .populated

            case .failure(let error):
                self.state = .error
                self.alertMessage = error.rawValue
            }
        }
    }
    
    
    //MARK: - fetch data and append in cell
    
    /// call each cell and return data by indexPath item
    /// - Parameter indexPath: indexPath item
    /// - Returns: PorductCellViewModel
    func getCellViewModel(at indexPath : IndexPath) -> PorductCellViewModel{
        return cellViewModel[indexPath.item]
    }
    
    
    ///  i fetch data and i put data  in PorductCellViewModel
    /// - Parameter product: Product
    /// - Returns: PorductCellViewModel
    func createCellViewModel( product: Product ) -> PorductCellViewModel {
        let productDescription = product.productDescription
        let image = product.image
        let price = product.price
        let hight = product.image.height
        let width = product.image.width
        let id    = product.id
        return PorductCellViewModel(id: id, productDescription: productDescription , image: image.url , price: price,height: hight,width: width )
    }
    
    
    
    /// fetch all product and for loop it  and append data in createCellViewModel
    /// - Parameter products: Product of data
    private func processFetchedProduct( products: [Product] ) {
        self.product = products // Cache
        var vms = [PorductCellViewModel]()
        for product in products {
            vms.append( createCellViewModel(product: product) )
        }
        self.cellViewModel = vms
    }
    
    
    
    /// fetch all product and for loop it  and append in product to  each scroll should add another product data.
    /// - Parameter products: Product of data
    func  processFetchedMoreProduct(products: [Product]){
        
        self.product.append(contentsOf: products)
        var vms = [PorductCellViewModel]()
        for product in products {
            vms.append( createCellViewModel(product: product) )
        }
        self.cellViewModel.append(contentsOf: vms)
    }
    
    
    /// once call it initFetchData in viewController the start state loading
    /// if get error change state to error and hide loading and show Alert
    /// and get data and make process
    func fetchMoredata(){
        state = .loading
        apiService.getProductList(){[weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let response):
                self.processFetchedMoreProduct(products: response)
                self.state = .populated
                
            case .failure(let error):
                self.state = .error
                self.alertMessage = error.rawValue

            }
        }
    }
    
    
    /// return when i selectedProduct cell get cell indexPath Item
    /// - Parameter indexPath: IndexPath item
    func productDetails( at indexPath: IndexPath ){
        let product = self.product[indexPath.row]
        self.selectedProduct = product
    }
    
    //MARK: - check Network connection
    
    // check Network connection
    // check network connection and get data
    // case unreachable that mean no internet connection
    // case wwan that mean via a cellular connection
    // case wwan that mean via a wifi connection
    
   
    
    func updateUserInterface() {
        
        switch Network.reachability.status {
        case .unreachable:
            getCachedData()
            initFetchProductData()
        case .wwan:
            initFetchProductData()
        case .wifi:
            initFetchProductData()
        }
    }
    
    
    
    func startCaching(){
        
        fileManager?.cacheProducts(with: product )
        
    }
    
    func getCachedData(){

        product = fileManager?.readCachedProducts() ?? []
        
    }
}
