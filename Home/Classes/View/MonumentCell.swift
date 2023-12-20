//
//  MonumentCell.swift
//  Home
//
//  Created by Enrique Alata Vences on 19/12/23.
//

import UIKit
import CoreEntities

class MonumentCell: UICollectionViewCell {
    let mainImageView = UIImageView()
    let titleLabel = UILabel()
    let distanceView = UIView()
    let distanceIcon = UIImageView()
    let distanceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Configuración de la imagen de fondo
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        contentView.addSubview(mainImageView)
        
        // Configuración del título
        titleLabel.numberOfLines = 0 // Permite múltiples líneas
        titleLabel.lineBreakMode = .byWordWrapping // Rompe las líneas por palabras
        if let principalColor = UIColor(named: "PrincipalColor") {
            titleLabel.backgroundColor = principalColor
        }
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        
        // Configuración de la vista de distancia
        distanceView.backgroundColor = .clear // Cambia según sea necesario
        contentView.addSubview(distanceView)
        
        // Configuración del icono de distancia
        distanceIcon.image = UIImage(systemName: "mappin.and.ellipse") // Ejemplo de icono
        distanceView.addSubview(distanceIcon)
        
        // Configuración de la etiqueta de distancia
        distanceLabel.textColor = .black // Cambia según sea necesario
        distanceView.addSubview(distanceLabel)
        
        // Activar Auto Layout
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        [mainImageView, titleLabel, distanceView, distanceIcon, distanceLabel].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview($0)
        }
        
        // Restricciones para mainImageView
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 1.5) // Altura mayor que la anchura
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20) // Altura mínima
        ])
        
        NSLayoutConstraint.activate([
            distanceView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            distanceView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10), // A 10 puntos del borde inferior
            distanceView.widthAnchor.constraint(equalToConstant: 100), // Ancho fijo
            distanceView.heightAnchor.constraint(equalToConstant: 40), // Altura fija
        ])
        
        NSLayoutConstraint.activate([
            distanceIcon.leadingAnchor.constraint(equalTo: distanceView.leadingAnchor, constant: 10),
            distanceIcon.centerYAnchor.constraint(equalTo: distanceView.centerYAnchor),
            distanceIcon.widthAnchor.constraint(equalToConstant: 20),
            distanceIcon.heightAnchor.constraint(equalToConstant: 20),
        ])

        NSLayoutConstraint.activate([
        distanceLabel.leadingAnchor.constraint(equalTo: distanceIcon.trailingAnchor, constant: 5),
        distanceLabel.centerYAnchor.constraint(equalTo: distanceView.centerYAnchor)
        ])
    }

    func configure(with monument: Monument) {
        titleLabel.text = monument.monument
        // Configura otros elementos aquí, como cargar la imagen desde `monument.image`
        // Nota: La carga de la imagen desde URL se manejará en el ViewController
        distanceLabel.text = "10 km" // Ejemplo de distancia
    }

    func configureWithPlaceholder() {
        mainImageView.image = UIImage(named: "PANTALLA DE CARGA COMPLETA (1)")
    }
}
