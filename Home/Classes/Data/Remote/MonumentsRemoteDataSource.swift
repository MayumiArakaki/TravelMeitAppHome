//
//  MonumentsRemoteDataSource.swift
//  Home
//
//  Created by Enrique Alata Vences on 17/12/23.
//

import Foundation

class MonumentsRemoteDataSource: MonumentsDataSourceProtocol {
    func list(completion: @escaping (Result<[MonumentsResponseDTO], Error>) -> Void) {
        MonumentsTask.doRequest(completion: completion)
    }
}
