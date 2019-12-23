//
//  PhotoDetailViewController.swift
//  GoodsPicker
//
//  Created by Roman on 23/12/2019.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoDetailViewController: UIViewController {
    
    var imageUrl: URL!
    var dismissTimeout: Double = 5.0
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .black
        
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let imageUrl = imageUrl, imageView.image == nil {
            imageView.sd_setImage(with: imageUrl) { (_, _, _, _) in
                DispatchQueue.main.asyncAfter(deadline: .now() + self.dismissTimeout) {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
