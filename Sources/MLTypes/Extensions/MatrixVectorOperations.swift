//
//  MatrixVectorOperations.swift
//
//
//  Created by Ivan Sanchez on 30/11/23.
//

import Foundation

extension MLMatrix {
    
    /// Calculates the dot product between a given vector and a specific row of this matrix.
        ///
        /// - Parameters:
        ///   - vector: The `MLVector<T>` to be dotted with a row of the matrix.
        ///   - rowIndex: The index of the row in the matrix to dot with the vector.
        /// - Returns: The resulting dot product as an element of type `T`.
    public func dot(with vector: MLVector<T>, atRow rowIndex: Int) -> T {
        precondition(vector.size == self.columns, "Cannot perform dot product: Matrix and vector must have compatible dimensions")
        precondition(rowIndex >= 0 && rowIndex < self.rows, "Cannot perform dot product: Row index out of bounds")
        
        return (0..<self.columns).reduce(into: T.zero) { result, columnIndex in
            result += self[rowIndex, columnIndex] * vector[columnIndex]
        }
    }
    
    
    /// Performs matrix-vector multiplication.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side `MLMatrix` of type `T`.
    ///   - rhs: The right-hand side `MLVector` of type `T`.
    /// - Returns: A new `MLVector<T>` resulting from the matrix-vector multiplication.
    static func *(lhs: MLMatrix<T>, rhs: MLVector<T>) -> MLVector<T> {
        precondition(lhs.columns == rhs.size, "Cannot perform Matrix-Vector *:  Matrix and vector must have compatible dimensions")
        var result = MLVector<T>(repeating: T.zero, size: lhs.rows)
        for rowIndex in 0..<lhs.rows {
            result[rowIndex] = lhs.dot(with: rhs, atRow: rowIndex)
        }
        return result
    }
}

extension MLVector {
    
    /// Performs vector-matrix multiplication.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side `MLVector` of type `T`.
    ///   - rhs: The right-hand side `MLMatrix` of type `T`.
    /// - Returns: A new `MLVector<T>` resulting from the vector-matrix multiplication.
    static func *(lhs: MLVector<T>, rhs: MLMatrix<T>) -> MLVector<T> {
        precondition(lhs.size == rhs.rows, "Cannot perform Vector-Matrix *:  Vector and matrix must have compatible dimensions")
        var result = MLVector<T>(repeating: T.zero, size: rhs.columns)
        for columnIndex in 0..<rhs.columns {
            let column = rhs.column(columnIndex)
            result[columnIndex] = lhs.dot(column)
        }
        return result
    }
}
