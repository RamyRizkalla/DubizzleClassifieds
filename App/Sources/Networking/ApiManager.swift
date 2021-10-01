//  Copyright © 2021 Ramy Rizkalla. All rights reserved.

import Foundation

class ApiManager {
    static var shared = ApiManager()
    private var urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchClassifiedsList(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: Environment.baseUrl)!
        data(from: url, completion: completion)
    }

    func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
        data(from: url) { data, _, error in
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }

    private func data(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = urlSession.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
}
