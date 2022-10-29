//
//  BaseService.swift
//  Recipe
//
//  Created by Jhonnatan Macias on 28/10/22.
//

import Alamofire
import Foundation

class BaseService {

    let baseURL: String
    let requestManager: Session

    init(baseURL: String) {
        self.baseURL = baseURL
        let configuration = URLSessionConfiguration.default

        requestManager = Session(configuration: configuration)

    }

    func getCodable<T: Decodable>(URL: String,
                                  headers: HTTPHeaders? = HTTPHeaders(["Content-Type": "application/json",
                                                                       "x-api-key": "4518de6c6b404152b43ec3aaae267c5f"]),
                                  parameters: [String: AnyObject]?,
                                  timeout: Double = 15,
                                  responseType: T.Type,
                                  completion: @escaping(_ response: T?, _ error: NSError?) -> Void) {


        requestManager.request(URL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseData(queue: DispatchQueue.global(qos: .userInteractive)) { (response) in
                guard let data: Data = response.data,
                      let urlResponse: HTTPURLResponse = response.response,
                      urlResponse.statusCode == 200 else {
                    let error: NSError = NSError(domain: "ERROR_NOT_PERFORMED", code: 666, userInfo: nil)
                    completion(nil, error)
                    return
                }
                do {
                    let objectResponse = try JSONDecoder().decode(responseType, from: data)

                    completion(objectResponse, nil)
                } catch let error {
                    completion(nil, error as NSError)
                }
            }
    }

}
