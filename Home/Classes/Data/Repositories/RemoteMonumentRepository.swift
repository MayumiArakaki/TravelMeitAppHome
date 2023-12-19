import Foundation
import CoreEntities

final class RemoteMonumentRepository: MonumentsRepositoryProtocol {
    
    var dataSource: MonumentsDataSourceProtocol
    
    init(dataSource: MonumentsDataSourceProtocol) {
        self.dataSource = dataSource
    }
    func performListRequest(completion: @escaping (Result<[Monument], Error>) -> Void) {
        dataSource.list { result in
            switch result {
            case .success(let monumentResponseDTO):
                
                var monumentDomainArray: [Monument] = []
                
                for monumentDTO in monumentResponseDTO {
                    monumentDomainArray.append(monumentDTO.toDomainMonument())
                }
                completion(.success(monumentDomainArray))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

