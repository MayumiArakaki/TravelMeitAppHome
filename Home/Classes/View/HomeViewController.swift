//
//  HomeViewController.swift
//
//
//  Created by Enrique Alata Vences on 5/12/23.
//

import UIKit
import CoreEntities

public class HomeViewController: UIViewController {
    var homeViewModel: HomeViewModelProtocol?

    lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let horizontalSpacing: CGFloat = 20 // Espaciado horizontal entre celdas y márgenes laterales
        let verticalSpacing: CGFloat = 20 // Espaciado vertical entre celdas y márgenes superior e inferior
        let numberOfItemsPerRow: CGFloat = 2
        let totalHorizontalSpacing = (numberOfItemsPerRow - 1) * horizontalSpacing + layout.sectionInset.left + layout.sectionInset.right
        let itemWidth = (UIScreen.main.bounds.width - totalHorizontalSpacing) / numberOfItemsPerRow

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = horizontalSpacing
        layout.minimumLineSpacing = verticalSpacing
        layout.sectionInset = UIEdgeInsets(top: verticalSpacing, left: horizontalSpacing, bottom: verticalSpacing, right: horizontalSpacing)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let dataSource = MonumentsRemoteDataSource()
        let repository = RemoteMonumentRepository(dataSource: dataSource)
        let useCase = MonumentsListingUseCase(monumentsRepository: repository)
        homeViewModel = HomeViewModel(useCase: useCase)
        
        homeViewModel?.delegate = self
        homeViewModel?.requestList()
        setupLayout()
        setupCollectionView()
        configuresignOffButton()
    }
    
    private func setupCollectionView() {
        view.addSubview(homeCollectionView)
        homeCollectionView.dataSource = self
        homeCollectionView.register(MonumentCell.self, forCellWithReuseIdentifier: "MonumentCell")

        let layout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let spacing: CGFloat = 20  // Espaciado entre celdas y márgenes laterales
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = spacing * (numberOfItemsPerRow - 1) + layout!.sectionInset.left + layout!.sectionInset.right
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / numberOfItemsPerRow

        // Ajuste para evitar el solapamiento vertical
        let itemHeight = itemWidth * 1.5  // Aumenta la altura para evitar la superposición

        layout?.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout?.minimumInteritemSpacing = spacing
        layout?.minimumLineSpacing = spacing
        layout?.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

        setupCollectionViewConstraints()
    }

    private func setupCollectionViewConstraints() {
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            homeCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


    
    private func setupLayout() {
        view.backgroundColor = .white
    }
    
    private func configuresignOffButton() {
        let signOffIcon = UIImage(systemName: "xmark")
        let signOffBarButton = UIBarButtonItem(image: signOffIcon, style: .plain, target: self, action: #selector(tapBackToRoot))
        navigationItem.rightBarButtonItem = signOffBarButton
    }
    
    @objc func tapBackToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel?.monuments?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonumentCell", for: indexPath) as? MonumentCell else {
            fatalError("Unable to dequeue MonumentCell")
        }
        
        // Configurar la celda con la imagen de placeholder
        cell.configureWithPlaceholder()

        if let monument = homeViewModel?.monuments?[indexPath.row] {
            cell.configure(with: monument)
            homeViewModel?.loadImage(from: monument.image) { image in
                DispatchQueue.main.async {
                    if collectionView.indexPath(for: cell) == indexPath {
                        cell.mainImageView.image = image
                    }
                }
            }
        }

        return cell
    }
}

extension HomeViewController: HomeViewModelDelegateProtocol {
    func homeEvent(state: ViewControllerState) {
        switch state {
        case .success:
            homeCollectionView.reloadData()
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        default:
            break
        }
    }
}
