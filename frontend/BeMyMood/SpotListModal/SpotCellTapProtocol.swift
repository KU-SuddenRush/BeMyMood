//
//  SpotCellTapProtocol.swift
//  BeMyMood
//
//  Created by YoonSub Lim on 2023/08/15.
//

import Foundation

protocol SpotCellTapDelegate: AnyObject{
    func moveToSpotDetail(spotId: Int)
}
