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
        party.gainExp(100)
        let liubeiExp = party.pcs[0].exp
        XCTAssert(liubeiExp == 100)
    }
    
    func testGainItems() throws {
        let party = Party()
        party.gainItems([1, 2, 3, 1])
        print(party.inventories)
        XCTAssert(party.inventories.keys.count == 4)
    }
}
