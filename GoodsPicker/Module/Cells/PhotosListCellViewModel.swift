//
//  PhotosListCellViewModel.swift
//  GoodsPicker
//
//  Created by Roman on 23/12/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

struct PhotosListCellViewModel {
    let titleText: String
    let thumbUrl: URL
}

extension PhotosListCellViewModel {
    init(title: String, photoModel: PhotoModel) {
        self.titleText = title
        self.thumbUrl = photoModel.thumb_url
    }
}
