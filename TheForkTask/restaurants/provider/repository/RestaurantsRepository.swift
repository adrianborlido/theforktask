//
//  RestaurantsRepository.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import Foundation
import Alamofire
import PromiseKit

protocol RestaurantsRepositoryInterface {
    func getRestaurants() -> Promise <RestaurantsResponse>
}

class RestaurantsRepository: RestaurantsRepositoryInterface {
    private lazy var restClient = RestClient()
    
    func getRestaurants() -> Promise <RestaurantsResponse> {
        return restClient.request(type: RestaurantsResponse.self,
                                  url: Constants.Endpoint.getRestaurants,
                                  method: .get,
                                  encoding: URLEncoding.queryString)
    }
}
