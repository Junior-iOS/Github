//
//  Bindable.swift
//  Github
//
//  Created by NJ Development on 28/05/23.
//

import Foundation

public class Bindable<T> {
    public typealias Listener = (T) -> ()
    
    // MARK: - Properties
    public var listeners: [Listener] = []
    
    public init(_ v: T) {
        value = v
    }
    
    public func bind(_ listener: @escaping Listener) {
        self.listeners.append(listener)
    }
    
    public var value: T {
        didSet {
            listeners.forEach { $0(value) }
        }
    }
}
