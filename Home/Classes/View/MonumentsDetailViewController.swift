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
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white  // Texto en blanco
        label.numberOfLines = 0  // Múltiples líneas si es necesario
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let infoBackgroundView: UIView = {
        let view = UIView()
        if let principalColor = UIColor(named: "PrincipalColor") {
            view.backgroundColor = principalColor.withAlphaComponent(0.6)  // Azul con opacidad del 50%
        }
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        setupBackgroundImageViewConstraints()
        setupBackgroundViewAndLabel()
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
    
    private func setupBackgroundViewAndLabel() {
        view.addSubview(infoBackgroundView)
        infoBackgroundView.addSubview(infoLabel)

        NSLayoutConstraint.activate([
            // Restricciones para infoLabel
            infoLabel.topAnchor.constraint(equalTo: infoBackgroundView.topAnchor, constant: 10),
            infoLabel.bottomAnchor.constraint(equalTo: infoBackgroundView.bottomAnchor, constant: -10),
            infoLabel.leadingAnchor.constraint(equalTo: infoBackgroundView.leadingAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: infoBackgroundView.trailingAnchor, constant: -10),

            // Restricciones para infoBackgroundView
            infoBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8) // 80% del ancho de la vista
        ])

        if let shortText = monument?.short {
            infoLabel.text = shortText
        }
    }

}
