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
        let liubei = Pc(id: Pc.liuBei)
        XCTAssert(liubei.requiredExp == 300)
        liubei.lv = 20
        XCTAssert(liubei.requiredExp == Int.max)
    }
}
