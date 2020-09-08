//
//  ChallengeRating.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/05.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

enum ChallengeRatting {
    case c0
    case c1_8
    case c1_4
    case c1_2
    case c1
    case c2
    case c3
    case c4
    case c5
    case c6
    case c7
    case c8
    case c9
    case c10
    
    func toExp() -> Int {
        switch self {
        case .c0:
            return 10
        case .c1_8:
            return 25
        case .c1_4:
            return 50
        case .c1_2:
            return 100
        case .c1:
            return 200
        case .c2:
            return 450
        case .c3:
            return 700
        case .c4:
            return 1_100
        case .c5:
            return 1_800
        case .c6:
            return 2_300
        case .c7:
            return 2_900
        case .c8:
            return 3_900
        case .c9:
            return 5_000
        case .c10:
            return 5_900
        }
    }
    
    func toProficiency() -> Int {
        switch self {
        case .c0:
            return 2
        case .c1_8:
            return 2
        case .c1_4:
            return 2
        case .c1_2:
            return 2
        case .c1:
            return 2
        case .c2:
            return 2
        case .c3:
            return 2
        case .c4:
            return 2
        case .c5:
            return 3
        case .c6:
            return 3
        case .c7:
            return 3
        case .c8:
            return 3
        case .c9:
            return 4
        case .c10:
            return 4
        }
    }
}
