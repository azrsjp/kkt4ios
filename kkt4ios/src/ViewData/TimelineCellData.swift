//
//  TimelineCellData.swift
//  kkt4ios
//
//  Created by tt on 2018/01/06.
//  Copyright © 2018年 gomachan_7. All rights reserved.
//

import Foundation

struct TimelineCellData {
    let id: String;
    let name: String;
    let screenName: String;
    let userId: String;
    let iconUrl: URL?;
    let text: String;
    let cwText: String;
    let mediaUrls: [URL];
    let isNSFW: Bool;
    let isFaved: Bool;
    let isBoosted: Bool;
    let date: TimeInterval;

    var hasCwText: Bool {
        get { return !self.cwText.isEmpty }
    }
    var hasMedia: Bool {
        get { return !self.mediaUrls.isEmpty }
    }
    
    static func genRandom() -> TimelineCellData {
        let hasCwText = arc4random_uniform(2) == 0;
        let hasMedia = arc4random_uniform(2) == 0;
        let isNSFW = arc4random_uniform(2) == 0;
        
        return TimelineCellData(
            id: "id",
            name: "七倉小春",
            screenName: "koharu",
            userId: "userid",
            iconUrl: URL(string: "http://www.aikatsu.net/character/images/bt_koharu.png"),
            text: "アイカツ最高",
            cwText: hasCwText ? "小春ちゃんも最高" : "",
            mediaUrls: hasMedia ? [URL(string: "dummy")!] : [],
            isNSFW: isNSFW,
            isFaved: false,
            isBoosted: false,
            date: 0
        )
    }
}

