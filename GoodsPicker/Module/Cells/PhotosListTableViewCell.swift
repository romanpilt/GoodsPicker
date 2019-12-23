//
//  PhotosListTableViewCell.swift
//  GoodsPicker
//
//  Created by Roman on 23/12/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class PhotosListTableViewCell: UITableViewCell {
    
    let netImageView: UIImageView
    let netImageTitle: UILabel
    
    var photosListCellViewModel : PhotosListCellViewModel? {
        didSet {
            self.netImageTitle.text = photosListCellViewModel?.titleText
            self.netImageView.sd_setImage(with: photosListCellViewModel?.thumbUrl, completed: nil)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        netImageView = UIImageView()
        netImageTitle = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        netImageView.contentMode = .scaleAspectFit
        netImageView.translatesAutoresizingMaskIntoConstraints = false
        
        netImageTitle.textAlignment = .center
        netImageTitle.adjustsFontSizeToFitWidth = true
        netImageTitle.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(netImageView)
        self.addSubview(netImageTitle)
        
        NSLayoutConstraint.activate([
            netImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            netImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            netImageView.heightAnchor.constraint(equalToConstant: 150),
            netImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            netImageTitle.leadingAnchor.constraint(equalTo: netImageView.trailingAnchor, constant: 15),
            netImageTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            netImageTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            netImageTitle.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
