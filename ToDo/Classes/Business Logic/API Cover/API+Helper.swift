//
//  API+Helper.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

import Foundation

extension API {
    
    /// Помощник
    final class Helper {
        
        // MARK: - Инициализация
        
        private init() { }
        
    }
    
}


// MARK: - Публичные методы

extension API.Helper {
    
    // MARK: - Обработка данных
    
    /// Преобразовать ключи
    static func translateKeys(_ source: [API.Argument : Any?]?) -> [String : Any?]? {
        guard let source = source else { return nil }
        
        var dictionary: [String : Any?] = [:]
        for (key, value) in source {
            dictionary[key.rawValue] = value
        }
        
        return dictionary
    }
    
    /// Удаление из словаря ключей, для которых установлено значение nil
    static func rejectNil(_ source: [String : Any?]?) -> [String : Any]? {
        guard let source = source else { return nil }
        
        var destination: [String : Any] = [:]
        for (key, nillableValue) in source {
            if let value = nillableValue {
                destination[key] = value
            }
        }
        
        return destination.isEmpty ? nil : destination
    }
    
    /// Получить закодированное значение
    static func applyPercentEncoding(for value: String) -> String {
        guard let cleanValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return .empty }
        return cleanValue
    }
    
    
    // MARK: - Работа с датами
    
    /// Получить строку формата HTTP из даты
    static func getHTTPDateString(from date: Date?) -> String? {
        guard let date = date else { return nil }
        return DateTimeFormatter.HTTPDateFormatter.string(from: date)
    }
    
    /// Получить дату из формата ISO8601, хранимую в строке
    static func getDate(fromISO8601String string: String?) -> Date? {
        guard let string = string else { return nil }
        return DateTimeFormatter.ISO8601DateFormatter.date(from: string)
    }
    
    /// Получить строку формата ISO8601 из даты
    static func getISO8601DateString(from date: Date?) -> String? {
        guard let date = date else { return nil }
        return DateTimeFormatter.ISO8601DateFormatter.string(from: date)
    }
    
}


// MARK: - Типы данных

private extension API.Helper {
    
    enum DateTimeFormatter {
        
        static var HTTPDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.timeZone = TimeZone(abbreviation: "GMT")
            formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss O"
            
            return formatter
        }()
        
        static var ISO8601DateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.timeZone = TimeZone(abbreviation: "GMT")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
            
            return formatter
        }()
        
    }
    
}
