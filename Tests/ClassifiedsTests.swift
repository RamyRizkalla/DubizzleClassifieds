//
//  ClassifiedsTests.swift
//  ClassifiedsTests
//
//  Created by Ramy Wagdy on 9/30/21.
//

import XCTest
@testable import Classifieds

class ClassifiedsTests: XCTestCase {
    private var fileReader: FileReader!
    private let mockJsonName = "ClassifiedsListMock"

    override func setUp() {
        fileReader = FileReader()
    }

    func testUrl() {
        let urlString = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer"
        XCTAssertEqual(Environment.baseUrl, urlString)
    }

    func testSuccessfulClassifiedsRequest() {
        prepareStubRequest()
        let expectation = self.expectation(description: "Wait For Mock Request")
        ApiManager(urlSession: URLSession.stub).fetchClassifiedsList { (data, response, error) in
            guard let data = data else {
                XCTFail("No Data Found")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                XCTFail("Unexpected Response Type")
                return
            }

            XCTAssertEqual(response.statusCode, 200)
            if let list = self.decodeData(data, type: ClassifiedsList.self) {
                XCTAssertEqual(list.results.count, 3)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    private func decodeData<T: Decodable>(_ data: Data, type: T.Type) -> T? {
        do {
            return try JSONDecoder.default.decode(type.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            XCTFail("Failed to decode model with error: \(context)")
        } catch let DecodingError.keyNotFound(key, context) {
            XCTFail("Key '\(key)' not found: \( context.debugDescription). CodingPath: \(context.codingPath)")
        } catch let DecodingError.valueNotFound(value, context) {
            XCTFail("Value '\(value)' not found: \( context.debugDescription). CodingPath: \(context.codingPath)")
        } catch let DecodingError.typeMismatch(type, context)  {
            XCTFail("Type '\(type)' mismatch: \( context.debugDescription). CodingPath: \(context.codingPath)")
        } catch {
            XCTFail("Failed to decode model with error: \(error.localizedDescription)")
        }
        return nil
    }

    private func prepareStubRequest() {
        guard let data = readMockJson(name: mockJsonName) else {
            XCTFail("Couldn't retirieve mock data")
            return
        }

        URLProtocolStub.error = nil
        URLProtocolStub.requestHandler = { request in
            let response = HTTPURLResponse(
                url: URL(string: Environment.baseUrl)!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
    }

    private func readMockJson(name: String) -> Data? {
        guard let bundlePath = Bundle(for: Self.self).path(forResource: name, ofType: "json") else { return nil }
        return try? String(contentsOfFile: bundlePath).data(using: .utf8)
    }
}
