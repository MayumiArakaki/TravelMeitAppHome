//
//  MonumentsRemoteDataSource.swift
//  Home
//
//  Created by Enrique Alata Vences on 17/12/23.
//

@testable import Home

class MonumentsMockDataSource: MonumentsDataSourceProtocol {
    func list(completion: @escaping (Result<[MonumentsResponseDTO], Error>) -> Void) {
        do {
            let responseDTO = try JSONDecoder().decode([MonumentsResponseDTO].self, from: Data(JSONDataProvider.monumentsDTOResponse.utf8))
            completion(.success(responseDTO))
        } catch {
            completion(.failure(error))
        }
    }
}
