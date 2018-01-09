//
//  StoryboardIdentifiable.swift
//  ToDo
//
//  Created by Илья Халяпин on 09.01.2018.
//  Copyright © 2018 Илья Халяпин. All rights reserved.
//

protocol StoryboardIdentifiable {
    
    /// Идентификатор view controller на storyboard
    static var storyboardIdentifier: String { get }
    
}
