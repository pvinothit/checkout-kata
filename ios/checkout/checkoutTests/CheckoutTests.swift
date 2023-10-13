//
//  checkoutTests.swift
//  checkoutTests
//
//  Created by Vinoth Palanisamy on 13/10/2023.
//

import XCTest
@testable import checkout

final class TestPrice: XCTestCase {
    func price(_ goods: String) -> Int {
        let co = Checkout(rules: Rules())
        goods.forEach { item in
            co.scan(item)
        }
        return co.total
    }
    
    func test_totals() {
        XCTAssertEqual(0, price(""))
        XCTAssertEqual(50, price("A"))
        XCTAssertEqual(80, price("AB"))
        XCTAssertEqual(115, price("CDBA"))
        XCTAssertEqual(100, price("AA"))
        XCTAssertEqual(130, price("AAA"))
        XCTAssertEqual(180, price("AAAA"))
        XCTAssertEqual(230, price("AAAAA"))
        XCTAssertEqual(260, price("AAAAAA"))
        XCTAssertEqual(160, price("AAAB"))
        XCTAssertEqual(175, price("AAABB"))
        XCTAssertEqual(190, price("AAABBD"))
        XCTAssertEqual(190, price("DABABA"))
    }
    
    func test_incremental() {
        let co = Checkout(rules: Rules())
        XCTAssertEqual(0, co.total)
        co.scan("A")
        XCTAssertEqual(50, co.total)
        co.scan("B")
        XCTAssertEqual(80, co.total)
        co.scan("A")
        XCTAssertEqual(130, co.total)
        co.scan("A")
        XCTAssertEqual(160, co.total)
        co.scan("B")
        XCTAssertEqual(175, co.total)
    }
}
