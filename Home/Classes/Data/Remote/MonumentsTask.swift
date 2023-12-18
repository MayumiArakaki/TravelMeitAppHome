//
//  MonumentsTask.swift
//  Home
//
//  Created by Enrique Alata Vences on 5/12/23.
//

import Foundation

struct ConnectionParameters {
    static let endpoint = "https://mocki.io/v1/e3d7bdc0-ff09-4ef5-af73-51b09797304c"
 }

class MonumentsTask {
    static func doRequest(completion: @escaping (Result<[MonumentsResponseDTO], Error>) -> Void) -> Void {
        
        let url = URL(string: ConnectionParameters.endpoint)!
        var request = URLRequest(url: url)

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    do {
                        let responseDTO = try JSONDecoder().decode([MonumentsResponseDTO].self, from: data)
                        completion(.success(responseDTO))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
    }
}
