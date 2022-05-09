//
//  RestaurantsRouter.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import Foundation
import UIKit

protocol RestaurantsRouterInterface {
    func goToRestaurants(window: UIWindow?)
}

class RestaurantsRouter: RestaurantsRouterInterface {
    func goToRestaurants(window: UIWindow?) {
        let restaurantsViewController = RestaurantsViewController()
        let repository: RestaurantsRepositoryInterface = RestaurantsRepository()
        restaurantsViewController.provider = RestaurantsProvider(delegate: restaurantsViewController, repository: repository)
        
        let navigationController = UINavigationController(rootViewController: restaurantsViewController)
        navigationController.navigationBar.barStyle = .black
        navigationController.modalPresentationStyle = .fullScreen
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
