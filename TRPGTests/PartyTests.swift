//
//  PartyTests.swift
//  TRPGTests
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import XCTest
@testable import TRPG

class PartyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGainExp() throws {
        let party = Party()
        let liubei = Pc(name: "Liu Bei", str: 12, dex: 12, con: 10, int: 12, wis: 14, cha: 17, mhp: 8)
        let guanyu = Pc(name: "Guan Yu", str: 12, dex: 12, con: 10, int: 12, wis: 14, cha: 17, mhp: 8)
        party.pcs.append(liubei)
        party.pcs.append(guanyu)
        party.gainExp(100)
        let liubeiExp = party.pcs[0].exp
        XCTAssert(liubeiExp == 50)
    }
}
