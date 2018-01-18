//
//  TimelineCell.swift
//  kkt4ios
//
//  Created by tt on 2018/01/04.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class TimelineCell: UICollectionViewCell, Reusable {

    // View
    @IBOutlet var userName: UILabel!
    @IBOutlet var screenName: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var text: UILabel!

    // contents warning text
    @IBOutlet var cwView: UIStackView!
    @IBOutlet var cwText: UILabel!
    @IBOutlet var cwTextWrapper: UIView!
    @IBOutlet var expandCWButton: UIButton!

    // attached images
    @IBOutlet var imagesView: UIStackView!
    @IBOutlet var nsfwCoverView: UIButton!

    // buttons
    @IBOutlet var replyButton: UIButton!
    @IBOutlet var boostButton: UIButton!
    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var othersButton: UIButton!

    // dynamic layout constraints
    @IBOutlet var widthLayout: NSLayoutConstraint!

    class func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }

    func setCellWidth(_ width: CGFloat) {
        widthLayout?.constant = width - 15 * 2
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setCellWidth(UIScreen.main.bounds.width)
    }

    // MARK: - private

    func setData(_ data: TimelineCellData) {
        userName?.text = data.name
        screenName?.text = "@" + data.screenName
        date?.text = "2018.1.7"
        text?.text = data.text
        cwText?.text = data.cwText
        cwView?.isHidden = !data.hasCwText
        expandCWButton?.isHidden = !data.hasCwText
        nsfwCoverView?.isHidden = data.isNSFW
        imagesView?.isHidden = data.hasMedia
    }
}
