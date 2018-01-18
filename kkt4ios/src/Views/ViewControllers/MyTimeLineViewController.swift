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

    @IBOutlet var collectionView: UICollectionView!

    private var listData: [TimelineCellData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    // MARK: - private

    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "TimelineCell", bundle: nil),
                                forCellWithReuseIdentifier: TimelineCell.reuseIdentifier)

        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
            flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
            flowLayout.minimumLineSpacing = 5
        }

        // MakeDummyData
        for _ in 1 ... 1000 {
            listData.append(TimelineCellData.genRandom())
        }

        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension MyTimeLineViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return listData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimelineCell.reuseIdentifier,
                                                      for: indexPath) as! TimelineCell
        cell.setData(listData[indexPath.row])

        return cell
    }
}
