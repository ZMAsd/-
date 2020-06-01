//
//  ZMSprotGameListCollectionViewCell.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import UIKit

class ZMSprotGameListCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var clubFirImageView: UIImageView!
    @IBOutlet weak var cludSecImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var tournamentNameLabel: UILabel!
    @IBOutlet weak var joinedTeamLabel: UILabel!
    
    var sportInfo: ZMSportData? {
        didSet {
            guard let sportInfo = sportInfo else {
                return
            }
            tournamentNameLabel.text = sportInfo.gameName! + sportInfo.tournamentShortName! + " / " + sportInfo.round!.uppercased()
            resultLabel.text = String(sportInfo.team?[1].score?.total ?? 0) + " - " + String(sportInfo.team?[0].score?.total ?? 0)
            clubFirImageView.sd_defaultSettingSetImage(withUrl: (sportInfo.team?[1].teamLogo)!)
            cludSecImageView.sd_defaultSettingSetImage(withUrl: (sportInfo.team?[0].teamLogo)!)
            joinedTeamLabel.text = sportInfo.matchShortName
            
//            registerButton.isHidden = !sportInfo.isMaxThanCurrent
            
            var title: String = ""
            var titleColor: UIColor = AppColor.ctaColor
            registerButton.isHidden = false
            if sportInfo.status == 2 {
                title = "正在进行中"
                registerButton.backgroundColor = AppColor.clearColor
            } else if sportInfo.status == 1 {
                title = "注册通知提醒"
                registerButton.backgroundColor = AppColor.backgroundColor
            } else {
                registerButton.isHidden = true
            }
            registerButton.setTitle(title, for: UIControl.State.normal)
            registerButton.setTitle(title, for: UIControl.State.selected)
            registerButton.setTitleColor(titleColor, for: UIControl.State.normal)
            registerButton.setTitleColor(titleColor, for: UIControl.State.selected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerButton.layer.cornerRadius = AppFrame.kCornerRadius
        registerButton.layer.masksToBounds = true
    }

    @IBAction func buttonClicked(_ sender: Any) {
        
    }
}
