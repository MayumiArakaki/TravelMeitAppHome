//
//  MonumentsRepositoryProtocol.swift
//  Home
//
//  Created by Enrique Alata Vences on 17/12/23.
//

import Foundation

protocol MonumentsRepositoryProtocol {
    func performListRequest(completion: @escaping (Result<[Monument], Error>) -> Void) -> Void
}
