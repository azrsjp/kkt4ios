//
//  TimelineViewController.swift
//  kkt4ios
//
//  Created by tt on 2018/01/03.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class MyTimeLineViewController: PagedViewControllerBase {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var listData: [TimelineCellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
    }
    
    // MARK: - private
    
    private func setupCollectionView() {
        self.collectionView.register(UINib(nibName: "TimelineCell", bundle: nil), forCellWithReuseIdentifier: TimelineCell.reuseIdentifier)
        
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
            flowLayout.sectionInset = UIEdgeInsetsMake(20, 15, 20, 15)
            flowLayout.minimumLineSpacing = 5
        }
        
        // MakeDummyData
        for _ in 1...1000 {
            self.listData.append(TimelineCellData.genRandom())
        }

        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
}

extension MyTimeLineViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimelineCell.reuseIdentifier, for: indexPath) as! TimelineCell
        cell.setData(self.listData[indexPath.row])

        return cell
    }
}
