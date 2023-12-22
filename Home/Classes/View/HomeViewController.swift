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
    var filteredMonuments: [Monument] = []

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
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Choose a country"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buscar", for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        setupTextFieldAndButton()
        setupCollectionView()
        configuresignOffButton()
        clearFilter()
        homeCollectionView.reloadData()
        print("printeando monuments")
        print(filteredMonuments)
        print("fin del printeo")
    }
    
    private func setupTextFieldAndButton() {
        searchTextField.delegate = self
        view.addSubview(searchTextField)
        view.addSubview(searchButton)

        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),

            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupCollectionView() {
        view.addSubview(homeCollectionView)
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
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
            homeCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            homeCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            homeCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc private func searchButtonTapped() {
        guard let searchText = searchTextField.text, !searchText.isEmpty else {
            clearFilter()
            print("No search text entered")
            return
        }

        filterMonuments(byCountry: searchText)
    }
    
    private func filterMonuments(byCountry country: String) {
        filteredMonuments = homeViewModel?.monuments?.filter { $0.pais.lowercased().contains(country.lowercased()) } ?? []
        homeCollectionView.reloadData()
    }
    
    private func clearFilter() {
        filteredMonuments = homeViewModel?.monuments ?? []
        homeCollectionView.reloadData()
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

extension HomeViewController: HomeViewModelDelegateProtocol {
    func homeEvent(state: ViewControllerState) {
        switch state {
        case .success:
            clearFilter()
        case .failure(let error):
            print("Error: \(error.localizedDescription)")
        default:
            break
        }
    }
}

/// Search
extension HomeViewController: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
//            clearFilter()
        }
    }
}
/*

/// CollectionViewDataSource
///
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

 */

/// CollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMonuments.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonumentCell", for: indexPath) as? MonumentCell else {
            fatalError("Unable to dequeue MonumentCell")
        }
        
        // Configurar la celda con la imagen de placeholder
        cell.configureWithPlaceholder()
        
        let monument = filteredMonuments[indexPath.row]
        cell.configure(with: monument)
        homeViewModel?.loadImage(from: monument.image) { image in
            DispatchQueue.main.async {
                if collectionView.indexPath(for: cell) == indexPath {
                    cell.mainImageView.image = image
                }
            }
        }
        
        return cell
    }
}


/// UIPickerViewDataSource
extension HomeViewController: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}

extension HomeViewController: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return "asasas"
        }
    
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Obtén el monumento seleccionado de la lista filtrada
        let selectedMonument = filteredMonuments[indexPath.row]
        
        // Inicializa el MonumentDetailViewController con el monumento seleccionado
        let detailVC = MonumentDetailViewController()
        detailVC.monument = selectedMonument
        print(selectedMonument)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
/*
extension HomeViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Obtén el monumento seleccionado
        if let selectedMonument = homeViewModel?.monuments?[indexPath.row] {
            // Inicializa el MonumentDetailViewController con el monumento seleccionado
            let detailVC = MonumentDetailViewController()
            detailVC.monument = selectedMonument  // Asegúrate de que MonumentDetailViewController tenga una propiedad 'monument'
            // Navega al MonumentDetailViewController
            print(selectedMonument)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
*/
