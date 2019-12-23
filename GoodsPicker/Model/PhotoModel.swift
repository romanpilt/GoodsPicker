//
//  PhotoModel.swift
//  GoodsPicker
//
//  Created by Roman on 23/12/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import UnsplashPhotoPicker

struct PhotoModel: Codable {
    let id: String
    let thumb_url: URL
    let image_url: URL
}

extension PhotoModel {
    init?(_ unsplashPhoto: UnsplashPhoto) {
        guard   let thumbURL = unsplashPhoto.urls[.thumb],
                let photoURL = unsplashPhoto.urls[.full] else { return nil }
        
        self.id = unsplashPhoto.identifier
        self.thumb_url = thumbURL
        self.image_url = photoURL
    }
}
