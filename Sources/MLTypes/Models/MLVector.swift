//
//  MLVector.swift
//
//
//  Created by Ivan Sanchez on 28/11/23.
//

import Foundation


struct MLVector<T> where T: Randomizable, T: Numeric {
    var elements: [T]
    
    var size: Int {
        return elements.count
    }
    
    public init(_ elements: [T]) {
        self.elements = elements
    }
    
    public init(repeating: T, size: Int) {
        self.elements = Array(repeating: repeating, count: size)
    }
    
    public init(size: Int, randomIn range: ClosedRange<T>)   {
        self.elements = (0..<size).map { _ in T.random(in: range) }
    }
    
    public init(size: Int, generator: (Int) -> T) {
        self.elements = (0..<size).map(generator)
    }
    
    
    // Vector-Vector operations
    
    public static func +(lhs: MLVector<T>, rhs: MLVector<T>) -> MLVector<T> {
        assert(lhs.size == rhs.size, "Vectors must have the same size")
        return MLVector<T>(zip(lhs.elements, rhs.elements).map(+))
    }
    
    public static func -(lhs: MLVector<T>, rhs: MLVector<T>) -> MLVector<T> {
        assert(lhs.size == rhs.size, "Vectors must have the same size")
        return MLVector<T>(zip(lhs.elements, rhs.elements).map(-))
    }
    
    public static func *(lhs: MLVector<T>, rhs: MLVector<T>) -> T {
        return lhs.dot(rhs)
    }
    
    public static func hadamardProduct(_ lhs: MLVector<T>, _ rhs: MLVector<T>) -> MLVector<T> {
        assert(lhs.size == rhs.size, "Vectors must have the same size")
        return MLVector<T>(zip(lhs.elements, rhs.elements).map(*))
    }
    
    public func dot(_ other: MLVector<T>) -> T {
        assert(self.size == other.size, "Vectors must have the same size")
        return zip(self.elements, other.elements).map(*).reduce(0, +)
    }
    
    // Vector-Scalar operations
   
    func increase(by scalar: T) -> MLVector<T> {
        return MLVector<T>(self.elements.map { $0 + scalar })
    }
    
    func decrease(by scalar: T) -> MLVector<T> {
        return MLVector<T>(self.elements.map { $0 - scalar })
    }
    
    func scale(by scalar: T) -> MLVector<T> {
        return MLVector<T>(self.elements.map { $0 * scalar })
    }

}


