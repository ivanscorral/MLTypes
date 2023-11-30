//
//  MLVector.swift
//
//
//  Created by Ivan Sanchez on 28/11/23.
//

import Foundation


public struct MLVector<T> where T: Randomizable, T: Numeric {
    var elements: [T]
    
    /// The number of elements in the
    ///
    /// - Returns: The number of elements in the vector.
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
    
    /// Computes the Hadamard product (element-wise multiplication) of two vectors.
    /// - Parameters:
    ///   - lhs: The left-hand side vector to multiply.
    ///   - rhs: The right-hand side vector to multiply.
    /// - Returns: A new `MLVector` representing the Hadamard product of the input vectors.
    /// - Precondition: Both vectors must have the same number of elements.
    public static func hadamardProduct(_ lhs: MLVector<T>, _ rhs: MLVector<T>) -> MLVector<T> {
        assert(lhs.size == rhs.size, "Vectors must have the same size")
        return MLVector<T>(zip(lhs.elements, rhs.elements).map { $0 * $1 })
    }
    
    /// Calculates the dot product of this vector with another vector.
    ///
    /// This function computes the sum of the products of corresponding elements
    /// from this vector and another vector of the same size. This operation is
    /// commonly known as the dot product or inner product. An assertion failure
    /// occurs if the vectors have different sizes.
    ///
    /// - Parameter other: The other vector to compute the dot product with.
    /// - Returns: The dot product of this vector and the `other` vector.
    /// - Complexity: O(n) where n is the number of elements in the vectors.
    func dot(_ other: MLVector<T>) -> T {
        assert(self.size == other.size, "Vectors must have the same size")
        return zip(self.elements, other.elements).map({ $0 * $1 }).reduce(0, +)
    }
    
    // Vector-Scalar operations

    /// Increases each element of the vector by a scalar value.
    ///
    /// - Parameter scalar: The scalar value to add to each element of the vector.
    /// - Returns: A new `MLVector` instance with each element increased by the scalar value.
    public func increase(by scalar: T) -> MLVector<T> {
        return self.map { $0 + scalar }
    }
    
    /// Decreases each element of the vector by a scalar value.
    ///
    /// - Parameter scalar: The scalar value to subtract from each element of the vector.
    /// - Returns: A new `MLVector` instance with each element decreased by the scalar value.
    public func decrease(by scalar: T) -> MLVector<T> {
        return self.map { $0 - scalar }
    }

    /// Scales each element of the vector by a scalar value.
    ///
    /// - Parameter scalar: The scalar value to multiply with each element of the vector.
    /// - Returns: A new `MLVector` instance with each element scaled by the scalar value.
    public func scale(by scalar: T) -> MLVector<T> {
        return self.map { $0 * scalar }
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


