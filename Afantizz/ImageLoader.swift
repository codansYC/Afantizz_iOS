//
//  UIIamgeView.swift
//  Afantizz
//
//  Created by yuanchao on 2018/1/31.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit
import Kingfisher

class _ImageLoader<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

protocol _ImageLoaderCompatible { }

extension _ImageLoaderCompatible {
    var af: _ImageLoader<Self> {
        return _ImageLoader(self)
    }
}

extension UIImageView: _ImageLoaderCompatible { }
extension UIButton: _ImageLoaderCompatible { }

extension _ImageLoader where Base: UIImageView {
    
    func setImage(with resource: Resource?,
                         placeholder: Placeholder? = nil,
                         options: KingfisherOptionsInfo? = nil,
                         progressBlock: DownloadProgressBlock? = nil,
                         completionHandler: CompletionHandler? = nil) {
        base.kf.setImage(with: resource, placeholder: placeholder, options: options, progressBlock: progressBlock, completionHandler: completionHandler)
    }
}

