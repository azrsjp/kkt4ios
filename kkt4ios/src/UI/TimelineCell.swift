//
//  TimelineCell.swift
//  kkt4ios
//
//  Created by tt on 2018/01/04.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TimelineCell: UICollectionViewCell, Reusable {
    
    // View
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var text: UILabel!

    // contents warning text
    @IBOutlet weak var cwView: UIStackView!
    @IBOutlet weak var cwText: UILabel!
    @IBOutlet weak var cwTextWrapper: UIView!
    @IBOutlet weak var expandCWButton: UIButton!
    
    // attached images
    @IBOutlet weak var imagesView: UIStackView!
    @IBOutlet weak var nsfwCoverView: UIButton!
    
    // buttons
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var boostButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var othersButton: UIButton!
    
    // dynamic layout constraints
    @IBOutlet weak var widthLayout: NSLayoutConstraint!

    class func nib() -> UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }

    func setCellWidth(_ width: CGFloat) {
        self.widthLayout?.constant = width - 15 * 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.setCellWidth(UIScreen.main.bounds.width)
    }
    
    // MARK:- private
    
    func setData(_ data: TimelineCellData) {
        self.userName?.text = data.name
        self.screenName?.text = "@" + data.screenName
        self.date?.text = "2018.1.7"
        self.text?.text = data.text
        self.cwText?.text = data.cwText
        self.cwView?.isHidden = !data.hasCwText
        self.expandCWButton?.isHidden = !data.hasCwText
        self.nsfwCoverView?.isHidden = data.isNSFW
        self.imagesView?.isHidden = data.hasMedia
    }
}
