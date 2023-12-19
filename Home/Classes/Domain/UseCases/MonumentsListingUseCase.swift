import Foundation
import CoreEntities

protocol MonumentsListingCaseProtocol {
    func execute(completion: @escaping (Result<[Monument], Error>) -> Void) -> Void
}

final class MonumentsListingUseCase: MonumentsListingCaseProtocol {

    private let monumentsRepository: MonumentsRepositoryProtocol

    init(monumentsRepository: MonumentsRepositoryProtocol) {
        self.monumentsRepository = monumentsRepository
    }

    func execute(
        completion: @escaping (Result<[Monument], Error>) -> Void
    ) -> Void {

        monumentsRepository.performListRequest(completion: { result in
            completion(result)
        })
    }
}
