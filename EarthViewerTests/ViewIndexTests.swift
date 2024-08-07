//
//  ViewIndexTests.swift
//  EarthViewerTests
//
//  Created by Alex Persian on 8/7/24.
//

import XCTest
@testable import EarthViewer

final class ViewIndexTests: XCTestCase {

    func test_WhenViewIndexInits_IndexIsWithinRange() {
        let testRange: Range<Int> = 0..<10
        let viewIndexUnderTest = ViewIndex(range: testRange)
        XCTAssert(testRange.contains(viewIndexUnderTest.index))
    }

    func test_WhenSettingValidViewIndex_NoError() {
        let testRange: Range<Int> = 0..<10
        let testIndex = 5
        let viewIndexUnderTest = ViewIndex(range: testRange)

        do {
            try viewIndexUnderTest.setIndex(to: testIndex)
            XCTAssertEqual(viewIndexUnderTest.index, testIndex)
        } catch {
            XCTFail("Error occurred when setting valid view index.")
        }
    }

    func test_WhenSettingInvalidIndex_ErrorOccurs() {
        let testRange: Range<Int> = 0..<10
        let testIndex = 15
        let viewIndexUnderTest = ViewIndex(range: testRange)

        do {
            try viewIndexUnderTest.setIndex(to: testIndex)
            XCTFail("Setting invalid view index should've thrown error.")
        } catch {
            XCTAssertNotEqual(viewIndexUnderTest.index, testIndex)
        }
    }

    func test_WhenViewIndexAdvances_IndexIsIncremented() throws {
        let testRange: Range<Int> = 0..<10
        let testIndex = 5
        let viewIndexUnderTest = ViewIndex(range: testRange)
        
        try viewIndexUnderTest.setIndex(to: testIndex)
        XCTAssertEqual(viewIndexUnderTest.index, testIndex)

        viewIndexUnderTest.advance()
        XCTAssertEqual(viewIndexUnderTest.index, testIndex + 1)
    }

    func test_WhenViewIndexAdvancesBeyondRange_IndexWrapsAround() throws {
        let testRange: Range<Int> = 0..<10
        let testIndex = 9
        let viewIndexUnderTest = ViewIndex(range: testRange)

        try viewIndexUnderTest.setIndex(to: testIndex)
        XCTAssertEqual(viewIndexUnderTest.index, testIndex)

        viewIndexUnderTest.advance()
        XCTAssertEqual(viewIndexUnderTest.index, 0)
    }

    func test_WhenViewIndexRewinds_IndexDecremented() throws {
        let testRange: Range<Int> = 0..<10
        let testIndex = 5
        let viewIndexUnderTest = ViewIndex(range: testRange)

        try viewIndexUnderTest.setIndex(to: testIndex)
        XCTAssertEqual(viewIndexUnderTest.index, testIndex)

        viewIndexUnderTest.rewind()
        XCTAssertEqual(viewIndexUnderTest.index, testIndex - 1)
    }

    func test_WhenViewIndexRewindsBeyondRange_IndexWrapsAround() throws {
        let testRange: Range<Int> = 0..<10
        let testIndex = 0
        let viewIndexUnderTest = ViewIndex(range: testRange)

        try viewIndexUnderTest.setIndex(to: testIndex)
        XCTAssertEqual(viewIndexUnderTest.index, testIndex)

        viewIndexUnderTest.rewind()
        XCTAssertEqual(viewIndexUnderTest.index, 9)
    }
}
