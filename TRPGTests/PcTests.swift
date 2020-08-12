//
//  PcTests.swift
//  TRPGTests
//
//  Created by Ma Xueyuan on 2020/08/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import XCTest
@testable import TRPG

class PcTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequiredExp() throws {
        let liubei = Pc(name: "Liu Bei", str: 12, dex: 12, con: 10, int: 12, wis: 14, cha: 17, lifeDice: 10)
        XCTAssert(liubei.requiredExp == 300)
        liubei.lv = 20
        XCTAssert(liubei.requiredExp == Int.max)
    }
}
