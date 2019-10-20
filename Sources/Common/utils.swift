//
//  utils.swift
//
//  Created by Jarno Le Conté on 20/10/2019.
//  Copyright © 2019 Jarno Le Conté. All rights reserved.
//

import Foundation

typealias Context = String

func isEqualContext(_ a: Any, _ b: Any) -> Bool {
    guard let a = a as? Context, let b = b as? Context else { return false }
    
    return a == b
}

enum ESDSDKTarget: Int32 {
    case HardwareAndSoftware = 0
    case HardwareOnly = 1
    case SoftwareOnly = 2
}

enum ESDSDKDeviceType: Int32 {
    case StreamDeck = 0
    case StreamDeckMini = 1
    case StreamDeckXL = 2
    case StreamDeckMobile = 3
}
