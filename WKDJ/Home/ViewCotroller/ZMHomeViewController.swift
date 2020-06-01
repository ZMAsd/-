//
//  ZMHomeViewController.swift
//  WKDJ
//
//  Created by admin on 2020/5/30.
//  Copyright © 2020 Min zhang. All rights reserved.
//

import UIKit
import JXSegmentedView
import SnapKit

class ZMHomeViewController: UIViewController, JXSegmentedViewDelegate, JXSegmentedListContainerViewDataSource {
    
    var segmentedView: JXSegmentedView!
    var segmentedDataSource: JXSegmentedTitleDataSource!
    var listContainerView: JXSegmentedListContainerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Game News"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "gameList", style: UIBarButtonItem.Style.done, target: self, action: #selector(showMoreGame))
        setupSubViews()
    }
    
    private func setupSubViews() {
        segmentedView = JXSegmentedView()
        segmentedView.delegate = self
        segmentedView.backgroundColor = AppColor.backgroundColor
        view.addSubview(self.segmentedView)
        
        //segmentedDataSource一定要通过属性强持有，不然会被释放掉
        segmentedDataSource = JXSegmentedTitleDataSource()
        //配置数据源相关配置属性
        segmentedDataSource.titles = ["Today", "Ended"]
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.titleNormalColor = AppColor.whiteColor
        segmentedDataSource.titleSelectedColor = AppColor.ctaColor
        segmentedDataSource.titleNormalFont = APPFont.secFont
        segmentedDataSource.titleSelectedFont = APPFont.mainFont
        //关联dataSource
        segmentedView.dataSource = self.segmentedDataSource
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 20
        indicator.indicatorColor = AppColor.ctaColor
        segmentedView.indicators = [indicator]
        
        listContainerView = JXSegmentedListContainerView(dataSource: self)
        view.addSubview(self.listContainerView)
        //关联listContainer
        segmentedView.listContainer = listContainerView
        
        segmentedView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(AppFrame.kNavigationBarH)
            make.left.right.equalToSuperview()
            make.height.equalTo(45)
        }
        listContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedView.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(0)
        }
    }
    
    @objc private func showMoreGame() {
        let layout = UICollectionViewFlowLayout.init()
        let gameListVC = ZMGameListCollectionViewController.init(collectionViewLayout: layout)
        self.navigationController?.pushViewController(gameListVC, animated: true)
    }
    
    //点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，而不关心具体是点击还是滚动选中的情况。
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
    // 点击选中的情况才会调用该方法
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        
    }
    // 滚动选中的情况才会调用该方法
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
        
    }
    // 正在滚动中的回调
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        
    }

    //返回列表的数量
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource.titles.count
    }
    //返回遵从`JXSegmentedListContainerViewListDelegate`协议的实例
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if (index == 0) {
            return ZMSportsViewController.init(matchType: 2)
        } else {
            return ZMSportsViewController.init(matchType: 4)
        }
    }
}
