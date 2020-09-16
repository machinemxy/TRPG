//
//  Magic.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/16.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

enum MagicType: String, Codable {
    case cure = "Cure"
    
    var target: TargetType {
        switch self {
        case .cure:
            return .ally
        }
    }
    
    var description: String {
        switch self {
        case .cure:
            return "recover 1D8 + charisma modifier + proficiency HP"
        }
    }
}

struct Magic: Codable {
    var magicType: MagicType
    var mp: Int
    var mmp: Int
}
