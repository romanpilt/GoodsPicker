//
//  PhotosListViewModel.swift
//  GoodsPicker
//
//  Created by Roman on 23/12/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

class PhotosListViewModel {
    
    var onTitleUpdate: ((String) -> Void)?
    var onPhotosListUpdate: (([PhotosListCellViewModel]) -> Void)?
    var onPhotoSelection: ((URL) -> Void)?

    private var photos: [PhotoModel] = [PhotoModel]()
    
    private var selectedPhoto: PhotoModel? {
        didSet {
            if let photo = selectedPhoto {
                self.onPhotoSelection?(photo.image_url)
            }
        }
    }
    
    private var cellViewModels: [PhotosListCellViewModel] = [PhotosListCellViewModel]() {
        didSet {
            self.onTitleUpdate?(String(format: "Photos picked: %d", cellViewModels.count))
            self.onPhotosListUpdate?(cellViewModels)
        }
    }
    
    private func createCellViewModels(count: Int, photos: [PhotoModel]) -> [PhotosListCellViewModel] {
        var cellVMs = [PhotosListCellViewModel]()
        for (index, photo) in photos.enumerated() {
            let title = String(format: "%d. %@", arguments: [count + index + 1, photo.id])
            cellVMs.append(PhotosListCellViewModel(title: title, photoModel: photo))
        }
        return cellVMs
    }
    
    func processPickedPhotos(photos: [PhotoModel]) {
        self.photos.append(contentsOf: photos)
        
        let currentVMCount = self.cellViewModels.count
        self.cellViewModels.append(contentsOf: createCellViewModels(count: currentVMCount,
                                                                    photos: photos))
    }
    
    func didSelectPhoto(at indexPath: IndexPath) {
        self.selectedPhoto = self.photos[indexPath.row]
    }
}
