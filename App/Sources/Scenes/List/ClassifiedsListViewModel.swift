//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import Foundation

class ClassifiedsListViewModel {
    private(set) var list: [Classified] = []
    private var model = ClassifiedsListModel()

    func fetchClassifiedsList(completion: @escaping (DError?) -> Void) {
        model.fetchClassifiedsList { [weak self] result in
            switch result {
            case let .success(model as ClassifiedsList):
                self?.list = model.results
                completion(nil)
            case let .failure(error as DError):
                completion(error)
            default:
                print("")
            }
        }
    }
}
