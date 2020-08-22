//
//  BattleTests.swift
//  TRPGTests
//
//  Created by Ma Xueyuan on 2020/08/23.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import XCTest
@testable import TRPG

class BattleTests: XCTestCase {
    struct Apple {
        var sweet: Int
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReduce() throws {
        let apples = [Apple(sweet: 1), Apple(sweet: 2), Apple(sweet: 3)]
        let totalSweet = apples.reduce(0) { $0 + $1.sweet }
        XCTAssert(totalSweet == 6)
    }
}

