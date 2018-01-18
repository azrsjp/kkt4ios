//
//  PagedViewControllerBase.swift
//  kkt4ios
//
//  Created by tt on 2018/01/03.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class PagedViewControllerBase: UIViewController, IndicatorInfoProvider {

    private var itemInfo: IndicatorInfo = ""

    // MARK: - IndicatorInfoProvider

    func indicatorInfo(for _: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
