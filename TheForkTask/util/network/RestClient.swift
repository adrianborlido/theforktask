//
//  RestClient.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import Foundation
import Alamofire
import PromiseKit

class RestClient {
    
    func request<T: Decodable>(
        type: T.Type?,
        url: Constants.Endpoint,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        encoding: ParameterEncoding) -> Promise<T> {
            let requestUrl: String = Constants.baseURL + url.rawValue
            
            return Promise { seal in
                AF.request(requestUrl, method: method, parameters: parameters, encoding: encoding, headers: headers)
                    .validate()
                    .response { (response) in
                        if let error = response.error {
                            seal.reject(error)
                        }
                        if let data = response.data {
                            do {
                                let deserializedObject = try JSONDecoder().decode(T.self, from: data)
                                seal.fulfill(deserializedObject)
                            } catch {
                                seal.reject(error)
                            }
                        }
                    }
            }
        }
}
