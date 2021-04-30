//
//  MenuDetailViewModel.swift
//  SideDishApp
//
//  Created by 이다훈 on 2021/04/30.
//

import Foundation
import Combine

class MenuDetailViewModel {
    private let menuDetailUseCase: MenuDetailUseCasePort
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var detail: Detail = Detail()
    
    init(menuDetailUseCase: MenuDetailUseCasePort) {
        self.menuDetailUseCase = menuDetailUseCase
    }
    
    convenience init() {
        let menuDetailUseCase = MenuDetailUseCase()
        self.init(menuDetailUseCase: menuDetailUseCase)
    }
    
    func fetchDetail(dish: String) {
        menuDetailUseCase.showDetail(dishId: dish)
            .sink(receiveCompletion: { result in
                    switch result {
                    case .finished:
                        break
                    case .failure(.urlError):
                        assertionFailure("url")
                    case .failure(.networkConnection):
                        assertionFailure("networkConnection")
                    case .failure(.responseNil):
                        assertionFailure("responseNil")
                    case .failure(.parsing):
                        assertionFailure("parsing")
                    case .failure(.unknown):
                        assertionFailure("unknown")
                    } },
                  
                  receiveValue: { data in
                    self.detail = data
                  })
            .store(in: &subscriptions)
    }
}
