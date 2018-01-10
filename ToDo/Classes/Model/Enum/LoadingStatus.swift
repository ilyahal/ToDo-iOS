//
//  LoadingStatus.swift
//  ToDo
//
//  Created by Илья Халяпин on 10.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

enum LoadingStatus {
    
    /// Неизвестное
    case unknown
    /// Данные загружаются
    case load
    /// Данные загружены
    case didLoad
    /// Получена ошибка
    case getError(message: String)
    
}

extension LoadingStatus: Equatable {
    
    static func ==(lhs: LoadingStatus, rhs: LoadingStatus) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown), (.load, .load), (.didLoad, .didLoad), (.getError, .getError):
            return true
            
        default:
            return false
        }
    }
    
}
