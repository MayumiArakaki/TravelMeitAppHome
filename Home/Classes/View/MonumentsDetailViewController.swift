//
//  MonumentsDetailViewController.swift
//  Home
//
//  Created by Enrique Alata Vences on 21/12/23.
//

import UIKit
import CoreEntities

class MonumentDetailViewController: UIViewController {
    var homeViewModel: HomeViewModelProtocol?
    var monument: Monument?
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // Para que la imagen cubra toda la vista
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        setupBackgroundImageViewConstraints()
        loadBackgroundImage()
    }

    private func setupBackgroundImageViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func loadBackgroundImage() {
        if let urlString = monument?.image, let url = URL(string: urlString) {
            // Cargar la imagen desde la URL
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.backgroundImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
