//
//  MLVector.swift
//
//
//  Created by Ivan Sanchez on 28/11/23.
//

import Foundation


public struct MLVector<T> where T: Randomizable, T: Numeric {
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

    /// Increases each element of the vector by a scalar value.
    ///
    /// - Parameter scalar: The scalar value to add to each element of the vector.
    /// - Returns: A new `MLVector` instance with each element increased by the scalar value.
    func increase(by scalar: T) -> MLVector<T> {
        return MLVector<T>(self.elements.map { $0 + scalar })
    }
    
    /// Decreases each element of the vector by a scalar value.
    ///
    /// - Parameter scalar: The scalar value to subtract from each element of the vector.
    /// - Returns: A new `MLVector` instance with each element decreased by the scalar value.
    func decrease(by scalar: T) -> MLVector<T> {
        return MLVector<T>(self.elements.map { $0 - scalar })
    }

    /// Scales each element of the vector by a scalar value.
    ///
    /// - Parameter scalar: The scalar value to multiply with each element of the vector.
    /// - Returns: A new `MLVector` instance with each element scaled by the scalar value.
    func scale(by scalar: T) -> MLVector<T> {
        return MLVector<T>(self.elements.map { $0 * scalar })
    }

    // Utility methods

    /// Converts the vector into a matrix.
    ///
    /// - Returns: A new `MLMatrix` instance representing the vector as a single-row matrix.
    func matrix() -> MLMatrix<T> {
        return MLMatrix<T>([self.elements])
    }

    /// Computes the transpose of the vector represented as a matrix.
    ///
    /// - Returns: A new `MLMatrix` instance representing the transpose of the vector.
    func transpose() -> MLMatrix<T> {
        return self.matrix().transpose()
    }

}

// MARK: - Subscripts

extension MLVector {
    subscript(index: Int) -> T {
        get {
            return self.elements[index]
        }
        set {
            self.elements[index] = newValue
        }
    }
}


