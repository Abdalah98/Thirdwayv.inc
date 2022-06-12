//
//  PersistenceManger.swift
//  Thirdwayv.inc-Task
//
//  Created by Abdalah on 12/06/2022.
//

import Foundation

import Foundation

enum PersistenceAction{
    case add,remove
}

enum PersistenceManger {
    
    static private let defults  = UserDefaults.standard
    enum Keys { static let products = "Products" }
    
    
    static func updateWith(favorite:Product,actionType:PersistenceAction,comleted:@escaping (ResoneError?)->Void){
        retrieveFavorites { result in
            switch result{
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        comleted(.alreadyInFetch)
                        return
                    }
                    
                    favorites.append(favorite)
                    
                case .remove: break
                    //$0 all item
                }
                comleted(save(favorites: favorites))
                
            case .failure(let error):
                comleted(error)
            }
        }
        
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[Product],ResoneError>)-> Void){
        guard let favoritesData = defults.object(forKey: Keys.products) as? Data else{
            completed(.success([]))
            return
        }
        
        do {
            let decodeable = JSONDecoder()
            let products = try decodeable.decode([Product].self, from: favoritesData)
            completed(.success(products))
        }catch{
            completed(.failure(.unableToFetch))
        }
    }
    
    
    static func save(favorites:[Product])->ResoneError?{
        do{
            let encoder = JSONEncoder()
            let encoderFavorites = try encoder.encode(favorites)
            defults.set(encoderFavorites, forKey: Keys.products)
            return nil
        }catch{
            return .unableToFetch
        }
    }
}
