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
        let liubei = LiuBei.create()
        XCTAssert(liubei.requiredExp == 300)
        liubei.lv = 20
        XCTAssert(liubei.requiredExp == Int.max)
    }
    
    func testEncode() {
        let liubei = LiuBei.create()
        let encoder = JSONEncoder()
        let data = try? encoder.encode(liubei)
        let str = String(data: data!, encoding: .utf8)!
        print(str)
    }
    
    func testStatusDescription() {
        let liubei = LiuBei.create()
        liubei.statuses.insert(.frozen)
        liubei.statuses.insert(.poisoned)
        print(liubei.statusDescription)
    }
}
