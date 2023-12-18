//
//  HomeViewController.swift
//
//
//  Created by Enrique Alata Vences on 5/12/23.
//

import UIKit

public class HomeViewController: UIViewController {
    
    var monumentos: [MonumentsResponseDTO] = []

    lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        configuresignOffButton()
    }
    
    private func setupLayout() {
        view.backgroundColor = .lightGray
    }
    
    private func configuresignOffButton() {
        let signOffIcon = UIImage(systemName: "xmark")
        let signOffBarButton = UIBarButtonItem(image: signOffIcon, style: .plain, target: self, action: #selector(tapBackToRoot))
        navigationItem.rightBarButtonItem = signOffBarButton
    }
    
    @objc func tapBackToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /*
     var monumentos: [MonumentData] = []
     let homeViewModel = HomeViewModel()
     
     let logoHomeLabel: UIImageView = {
     let imageView = UIImageView()
     if let originalImage = UIImage(named: "logoTravelmeit") {
     let newSize = CGSize(width: originalImage.size.width / 2, height: originalImage.size.height / 2)
     UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
     originalImage.draw(in: CGRect(origin: .zero, size: newSize))
     let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()
     
     imageView.image = resizedImage
     }
     imageView.contentMode = .scaleAspectFit
     imageView.translatesAutoresizingMaskIntoConstraints = false
     return imageView
     }()
     
     // Crear una instancia de UICollectionView
     lazy var collectionView: UICollectionView = {
     let layout = UICollectionViewFlowLayout()
     let width = UIScreen.main.bounds.width / 2
     layout.itemSize = CGSize(width: width, height: width)
     layout.minimumInteritemSpacing = 0
     layout.minimumLineSpacing = 0
     let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
     collectionView.backgroundColor = .white
     collectionView.translatesAutoresizingMaskIntoConstraints = false
     return collectionView
     }()
     
     
     
     override func viewDidLoad() {
     super.viewDidLoad()
     
     view.backgroundColor = .white  // Establece el color de fondo de la vista principal
     
     setupLayout()
     configureCollectionView()
     homeViewModel.onUpdate = { [weak self] result in
     DispatchQueue.main.async {
     switch result {
     case .success(let monumentData):
     self?.monumentos = monumentData
     self?.collectionView.reloadData()  // Recargar los datos del collectionView
     case .failure(let error):
     print(error.localizedDescription)
     }
     }
     }
     homeViewModel.fetchData()
     }
     
     func setupLayout() {
     view.addSubview(logoHomeLabel)
     view.addSubview(collectionView)
     
     NSLayoutConstraint.activate([
     logoHomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
     logoHomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
     
     collectionView.topAnchor.constraint(equalTo: logoHomeLabel.bottomAnchor, constant: 20),
     collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
     collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
     collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
     ])
     }
     
     func configureCollectionView() {
     collectionView.dataSource = self
     collectionView.delegate = self
     collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
     }
     
     }
     */
}
    
