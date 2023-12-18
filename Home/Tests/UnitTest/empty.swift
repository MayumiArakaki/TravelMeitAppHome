//
//  MonumentsTask.swift
//  Home
//
//  Created by Enrique Alata Vences on 5/12/23.
//

import Foundation

class MonumentsTask {
    var onUpdate: ((Result<[MonumentsResponseDTO], Error>) -> Void)?
    
    func fetchData() {
        let urlString = "https://mocki.io/v1/e3d7bdc0-ff09-4ef5-af73-51b09797304c"
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status Code: \(httpResponse.statusCode)")
                    print("Response Headers: \(httpResponse.allHeaderFields)")
                }
                
                if let error = error {
                    print("Error: \(error)")
                    self?.onUpdate?(.failure(error))
                    return
                }
                
                guard let data = data, !data.isEmpty else {
                    print("No data or data is empty")
                    self?.onUpdate?(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                    return
                }
                
                if let responseString = String(data: data, encoding: .utf8), !responseString.isEmpty {
                    print("Response String: \(responseString)")
                } else {
                    print("Response String is empty")
                }
                
                do {
                    let monumentData = try JSONDecoder().decode([MonumentsResponseDTO].self, from: data)
                    self?.onUpdate?(.success(monumentData))
                } catch {
                    print("Decoding error: \(error)")
                    self?.onUpdate?(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
