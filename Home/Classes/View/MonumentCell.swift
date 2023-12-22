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
        
        // Activar Auto Layout
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        [mainImageView, titleLabel].forEach {
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
    }

    func configure(with monument: Monument) {
        titleLabel.text = monument.monument
    }

    func configureWithPlaceholder() {
        mainImageView.image = UIImage(named: "PANTALLA DE CARGA COMPLETA (1)")
    }
}
