//
//  NetworkManager.swift
//  Weather
//
//  Created by Macbook Pro  on 09.12.2020.
//
import Foundation
import Alamofire

class NetworkManager {
    
    public func request(_ url: URL?, result: @escaping (Result<Data?, Error>) -> Void) {
        guard let url = url else {
            result(.failure(URLError(.badURL)))
            return
        }
        AF.request(url).validate().response { (afResponse) in
            if let error = afResponse.error {
                result(.failure(error))
            } else { result(.success(afResponse.data)) }
        }
    }
}
