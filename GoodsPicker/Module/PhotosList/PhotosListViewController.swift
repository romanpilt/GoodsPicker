//
//  PhotosListViewController.swift
//  GoodsPicker
//
//  Created by Roman on 23/12/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import UnsplashPhotoPicker

class PhotosListViewController: UIViewController {
    
    private lazy var unsplashNav: UnsplashPhotoPicker = {
        let unsplashConfig = UnsplashPhotoPickerConfiguration(accessKey: ServiceKeys.Unsplash.accessKey, secretKey: ServiceKeys.Unsplash.secretKey, query: nil, allowsMultipleSelection: false, memoryCapacity: 50, diskCapacity: 100)
        return UnsplashPhotoPicker(configuration: unsplashConfig)
    }()
    
    private let cellID = "photoCellIdentifier"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PhotosListTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        return tableView
    }()
    
    lazy var viewModel: PhotosListViewModel = {
        return PhotosListViewModel()
    }()
    
    var cellViewModels: [PhotosListCellViewModel] = []
    
    private var selectedPhoto: PhotoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Select photo"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPhoto))
        
        unsplashNav.photoPickerDelegate = self
        
        setupView()
        
        setupVM()
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupVM() {
        viewModel.onTitleUpdate = { [weak self] (title) in
            DispatchQueue.main.async {
                self?.navigationItem.title = title
            }
        }
        
        viewModel.onPhotosListUpdate = { [weak self] (cellVMs) in
            DispatchQueue.main.async {
                self?.cellViewModels = cellVMs
                self?.tableView.reloadData()
            }
        }
        
        viewModel.onPhotoSelection = { [weak self] (photoUrl) in
            DispatchQueue.main.async {
                self?.openDetailScreenWithPhotoURL(photoUrl)
            }
        }
    }
    
    @objc func addPhoto() {
        self.present(unsplashNav, animated: true, completion: nil)
    }
}

extension PhotosListViewController: UnsplashPhotoPickerDelegate {
    func unsplashPhotoPicker(_ photoPicker: UnsplashPhotoPicker, didSelectPhotos photos: [UnsplashPhoto]) {
        self.viewModel.processPickedPhotos(photos: photos.compactMap({ PhotoModel($0) }))
    }
    
    func unsplashPhotoPickerDidCancel(_ photoPicker: UnsplashPhotoPicker) {}
}

extension PhotosListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? PhotosListTableViewCell else {
            fatalError("No such cell")
        }
        cell.selectionStyle = .none
        cell.photosListCellViewModel = self.cellViewModels[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectPhoto(at: indexPath)
    }
}

//MARK: - Navigation

extension PhotosListViewController {
    private func openDetailScreenWithPhotoURL(_ photoURL: URL) {
        let vc = PhotoDetailViewController()
        vc.imageUrl = photoURL
        DispatchQueue.main.async {
            self.present(vc, animated: true, completion: nil)
        }
    }
}
