//
//  RestaurantsProvider.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import Foundation

protocol RestaurantsProviderInterface {
    var delegate: RestaurantsProviderDelegate? { get }
    var repository: RestaurantsRepositoryInterface? { get }
    
    var restaurants: [Restaurant]? { get }
    
    func getRestaurants()
    func sortRestaurants(by: SortType)
    
    init(delegate: RestaurantsProviderDelegate, repository: RestaurantsRepositoryInterface)
}

protocol RestaurantsProviderDelegate: AnyObject {
    func getRestaurantsSucceed()
    func getRestaurantsFailed()
}

class RestaurantsProvider: RestaurantsProviderInterface {
    weak var delegate: RestaurantsProviderDelegate?
    var repository: RestaurantsRepositoryInterface?
    
    var restaurants: [Restaurant]?
    
    required init(delegate: RestaurantsProviderDelegate,
                  repository: RestaurantsRepositoryInterface) {
        self.delegate = delegate
        self.repository = repository
    }
    
    func getRestaurants() {
        repository?.getRestaurants()
            .done {[weak self] (response) in
                self?.restaurants = response.data
                self?.delegate?.getRestaurantsSucceed()
        }
            .catch {[weak self] (_) in
                print("❌ ERROR: COULD NOT GET RESTAURANTS")
                self?.delegate?.getRestaurantsFailed()
        }
    }
    
    func sortRestaurants(by type: SortType) {
        switch type {
        case .name:
            self.restaurants = restaurants?.sorted(by: {$0.name ?? "" < $1.name ?? "" })
        case .rating:
            self.restaurants = restaurants?.sorted(by: {$0.aggregateRating?.thefork?.ratingValue ?? 0.0 > $1.aggregateRating?.thefork?.ratingValue ?? 0.0 })
        }
    }
    
}
