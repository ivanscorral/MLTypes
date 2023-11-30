//
//  MLVectorExtensions.swift
//
//
//  Created by Ivan Sanchez on 28/11/23.
//

import Foundation

extension MLVector {
    /// Applies a transformation to each element of the vector and returns a new vector containing the results.
    /// - Parameter transform: A closure that takes an element of the vector as its argument and returns a transformed value of the same type.
    /// - Returns: A new `MLVector` instance where each element is the result of calling the `transform` function on corresponding elements of the calling vector.
    public func map(_ transform: (T) -> T) -> MLVector<T> {
        return MLVector<T>(self.elements.map(transform))
    }
}
