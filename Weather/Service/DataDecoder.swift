//
//  DataDecoder.swift
//  Weather
//
//  Created by Macbook Pro  on 12.01.2021.
//

import Foundation

class DataDecoder {
    public func decode<T: Codable>(from data: Data, to decodeType: T.Type) -> T? {
        try? JSONDecoder().decode(decodeType, from: data)
    }
}
