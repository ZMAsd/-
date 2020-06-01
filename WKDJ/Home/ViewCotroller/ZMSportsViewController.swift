//
//  ZMSportsViewController.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import UIKit
import JXSegmentedView

class ZMSportsViewController: UIViewController, JXSegmentedListContainerViewListDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var matchType: Int = 1
    lazy var viewModel: HomeViewModel = {
        let viewModel = HomeViewModel.init(matchType: self.matchType) { [unowned self] (isHeader: Bool, moMoreData: Bool) in
            // 刷新数据
            if isHeader {
                self.collectionView.mj_header?.endRefreshing()
            } else if isHeader == false, moMoreData == true {
                self.collectionView.mj_footer?.endRefreshingWithNoMoreData()
            } else {
                self.collectionView.mj_footer?.endRefreshing()
            }
            self.collectionView.reloadData()
        }
        return viewModel
    }()
    
    convenience init(matchType: Int) {
        self.init()
        self.matchType = matchType
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.zm_dequeueReusableCell(aClass: ZMSprotGameListCollectionViewCell.self, indexPath: indexPath)
        cell?.contentView.backgroundColor = AppColor.themeColor
        cell?.layer.cornerRadius = 5
        cell?.layer.masksToBounds = true
        if indexPath.section < viewModel.dataArray!.count {
            cell!.sportInfo = viewModel.dataArray![indexPath.section]
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: AppFrame.screenWidth - 10 * 2, height: 330)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    func listView() -> UIView {
        return view
    }
    
    func listWillAppear() {
        
    }
    
    func listDidAppear() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.zm_registerNibCell(aClass: ZMSprotGameListCollectionViewCell.self)
        collectionView.reloadData()
        collectionView.backgroundColor = AppColor.backgroundColor
        view.backgroundColor = AppColor.backgroundColor
        
        collectionView.zm_header {
            self.viewModel.fetchData();
        }
        
        collectionView.zm_footer {
            self.viewModel.fetchMoreData()
        }
        
        collectionView.mj_header?.beginRefreshing()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
