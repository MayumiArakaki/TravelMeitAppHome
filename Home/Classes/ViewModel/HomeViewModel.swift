//
//  HomeViewModel.swift
//  Login
//
//  Created by Enrique Alata Vences on 5/12/23.
//

import CoreEntities

protocol HomeViewModelDelegateProtocol: AnyObject {
    func homeEvent(state: ViewControllerState)
}

enum ViewControllerState {
    case loading
    case success
    case failure(Error)
}

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegateProtocol? { get set }
    var monuments: [Monument]? { get set }
    func requestList()
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}

final class HomeViewModel: HomeViewModelProtocol {
    var useCase: MonumentsListingUseCase
    var monuments: [Monument]?
    weak var delegate: HomeViewModelDelegateProtocol?

    init(useCase: MonumentsListingUseCase) {
        self.useCase = useCase
    }
    
    func requestList() {
        delegate?.homeEvent(state: .loading)
        useCase.execute(completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.monuments = response
                self?.delegate?.homeEvent(state: .success)
            case .failure(let error):
                self?.delegate?.homeEvent(state: .failure(error))
            }
        })
    }

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }.resume()
    }
}
