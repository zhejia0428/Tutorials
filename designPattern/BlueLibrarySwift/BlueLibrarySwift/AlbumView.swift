//
//  AlbumView.swift
//  BlueLibrarySwift
//
//  Created by Zhe Jia on 7/6/17.
//  Copyright © 2017 Raywenderlich. All rights reserved.
//

import UIKit

class AlbumView: UIView {

    fileprivate var coverImage: UIImageView?
    fileprivate var spinner: UIActivityIndicatorView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    init(frame: CGRect, albumCover: String) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = UIColor.black
        coverImage = UIImageView(frame: CGRect(x: 5.0, y: 5.0, width: frame.size.width - 5, height: frame.size.height - 5))
        addSubview(coverImage!)
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinner?.center = center
        addSubview(spinner!)
    }
    
    func highlightAlbum(_ didHighlightView: Bool) {
        if didHighlightView == true {
            backgroundColor = UIColor.white
        }
        else {
            backgroundColor = UIColor.black
        }
    }

}
