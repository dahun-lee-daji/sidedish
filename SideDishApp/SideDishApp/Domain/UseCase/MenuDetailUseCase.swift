//
//  MenuDetailUseCase.swift
//  SideDishApp
//
//  Created by 이다훈 on 2021/04/30.
//

import Foundation
import Combine

protocol MenuDetailUseCasePort {
    func showDetail(dishId: String) -> AnyPublisher<Detail, NetworkError>
}

class MenuDetailUseCase: MenuDetailUseCasePort {
    
    private let dishNetworkManager = DishNetworkManager()
    
    func showDetail(dishId: String) -> AnyPublisher<Detail, NetworkError> {
        return dishNetworkManager.getDetail(path: dishId)
    }
}
