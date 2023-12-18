//
//  HomeViewModel.swift
//  Login
//
//  Created by Enrique Alata Vences on 5/12/23.
//

import Foundation
import UIKit

class HomeViewModel {
    
/*    var onUpdate: ((Result<[MonumentData], Error>) -> Void)?
    
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
                    let monumentData = try JSONDecoder().decode([MonumentData].self, from: data)
                    self?.onUpdate?(.success(monumentData))
                } catch {
                    print("Decoding error: \(error)")
                    self?.onUpdate?(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    // Closure para actualizar la vista cuando los datos estén listos o haya un error
    func loadImage(for monument: MonumentData, completion: @escaping (UIImage?) -> Void) {
        // Suponiendo que tienes un servicio de carga de imágenes llamado `ImageLoadingService`
        ImageLoadingService.shared.loadImage(from: monument.image, completion: completion)
    }
    
    class ImageLoadingService {

        static let shared = ImageLoadingService()

        private init() {}

        func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }

            task.resume()
        }
    }
 */
}
