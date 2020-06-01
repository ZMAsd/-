//
//  ZMGameListCollectionViewCell.swift
//  WKDJ
//
//  Created by admin on 2020/5/31.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import UIKit

class ZMGameListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    var gameInfo: ZMGameDetailInfo? {
        didSet {
            guard let gameInfo = gameInfo else {
                return
            }
            gameTitleLabel.text = gameInfo.shortName!
            gameImageView.sd_defaultSettingSetImage(withUrl: gameInfo.logo!)
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = AppColor.themeColor
        contentView.backgroundColor = AppColor.backgroundColor
    }
}
