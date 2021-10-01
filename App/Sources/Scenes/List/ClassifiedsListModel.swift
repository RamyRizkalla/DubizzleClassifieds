//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import Foundation

class ClassifiedsListModel {
    private var apiManager: ApiManager

    init() {
        if ProcessInfo.processInfo.isUITesting {
            apiManager = ApiManager(urlSession: URLSession.stub)
            prepareStubRequest()
        } else {
            apiManager = ApiManager()
        }
    }

    func fetchClassifiedsList(completion: @escaping (Result) -> Void) {
        apiManager.fetchClassifiedsList { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self?.decodeResponse(data!, completion: completion)
            }
        }
    }

    private func decodeResponse(_ data: Data, completion: @escaping (Result) -> Void) {
        do {
            let weatherResponse = try JSONDecoder.default.decode(ClassifiedsList.self, from: data)
            completion(.success(weatherResponse))
        } catch {
            let error = DError(type: .clientSide, message: "An unexpected error happened while preparing data")
            completion(.failure(error))
        }
    }

    private func prepareStubRequest() {
        guard let data = FileReader().readJson(forName: "ClassifiedsListMock") else { return }

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
}
