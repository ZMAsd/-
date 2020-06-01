//
//  UICollectionViewExtension.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func zm_registerNibCell<T: UICollectionViewCell>(aClass: T.Type) {
        let identifier = String(describing: aClass)
        let nib = UINib.init(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func zm_dequeueReusableCell<T: UICollectionViewCell>(aClass: T.Type, indexPath: IndexPath) -> T! {
        let identifier = String(describing: aClass)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("\(identifier) is not registed")
        }
        return cell
    }
    
    func zm_header(success: @escaping (() -> ())) {
        let header = MJRefreshNormalHeader.init {
            success()
        }
        header.stateLabel?.isHidden = true
        header.loadingView?.style = UIActivityIndicatorView.Style.medium
        header.loadingView?.color = UIColor.white
        mj_header = header
    }
    
    func zm_footer(success: @escaping (() -> ())) {
        let footer = MJRefreshAutoStateFooter.init {
            success()
        }
        footer.isRefreshingTitleHidden = true
        footer.setTitle("", for: MJRefreshState.idle)
        footer.setTitle("", for: MJRefreshState.refreshing)
        footer.setTitle("——no more data——", for: MJRefreshState.noMoreData)
        
        mj_footer = footer;
    }
}
