//
//  MLMatrix.swift
//  
//
//  Created by Ivan Sanchez on 28/11/23.
//

import Foundation

public struct MLMatrix<T> where T: Randomizable, T: Numeric {
    var grid: [[T]]
    
    public var rows: Int { return grid.count }
    public var columns: Int { return grid[0].count }
    
    public init(_ grid: [[T]]) {
        self.grid = grid
    }
    
    public init(rows: Int, columns: Int) {
        self.grid = [[T]](repeating: [T](repeating: T.zero, count: columns), count: rows)
    }
    
    public init(rows: Int, columns: Int, defaultValue: T) {
        self.grid = [[T]](repeating: [T](repeating: defaultValue, count: columns), count: rows)
    }
    
    public init(in range: ClosedRange<T>, randomRows: Int, columns: Int, value:T) {
        self.grid = [[T]](repeating: [T](repeating: T.random(in: range), count: columns), count: randomRows)
    }
    
    /// Retrieves a column from the matrix as a vector.
    ///
    /// - Parameter index: An Int representing the index of the column to retrieve. The index is zero-based.
    /// - Returns: An MLVector<T> representing the column at the specified index.
    func column(_ index: Int) -> MLVector<T> {
        return MLVector<T>(grid.map { $0[index] })
    }
    
    /// Retrieves a row from the matrix as a vector.
    ///
    /// - Parameter index: An Int representing the index of the row to retrieve. The index is zero-based.
    /// - Returns: An MLVector<T> representing the row at the specified index.
    func row(_ index: Int) -> MLVector<T> {
        return MLVector<T>(grid[index])
    }
    
    // Matrix operations
    
    /// Computes the transpose of the matrix.
    ///
    /// - Returns: A new `MLMatrix` instance representing the transpose of the matrix, where the rows become columns and vice versa.
    func transpose() -> MLMatrix<T> {
        var result = MLMatrix<T>(rows: self.columns, columns: self.rows)
        
        for i in 0..<self.rows {
            for j in 0..<self.columns {
                result[j][i] = self[i][j]
            }
        }
        
        return result
    }

    /// Applies a transformation to each element of the matrix.
    ///
    /// - Parameter transform: A closure that takes an element of type `T` and returns it in the transformed form.
    /// - Returns: A new `MLMatrix` instance where each element has been transformed using the provided closure.
    func map(_ transform: (T) -> T) -> MLMatrix<T> {
        var result = MLMatrix<T>(rows: self.rows, columns: self.columns)
        
        for i in 0..<self.rows {
            for j in 0..<self.columns {
                result[i][j] = transform(self[i][j])
            }
        }
        
        return result
    }
    
    static func +(lhs: MLMatrix<T>, rhs: MLMatrix<T>) -> MLMatrix<T> {
        precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions must be equal")
        var result = MLMatrix<T>(rows: lhs.rows, columns: lhs.columns)
        
        for i in 0..<lhs.rows {
            for j in 0..<lhs.columns {
                result[i][j] = lhs[i][j] + rhs[i][j]
            }
        }
        
        return result
    }
    
    static func -(lhs: MLMatrix<T>, rhs: MLMatrix<T>) -> MLMatrix<T> {
        precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, "Matrix dimensions must be equal")
        var result = MLMatrix<T>(rows: lhs.rows, columns: lhs.columns)
        
        for i in 0..<lhs.rows {
            for j in 0..<lhs.columns {
                result[i][j] = lhs[i][j] - rhs[i][j]
            }
        }
        
        return result
    }
    
    static func *(lhs: MLMatrix<T>, rhs: MLMatrix<T>) -> MLMatrix<T> {
        precondition(lhs.columns == rhs.rows, "Matrix dimensions must be equal")
        var result = MLMatrix<T>(rows: lhs.rows, columns: rhs.columns)
        
        for i in 0..<lhs.rows {
            for j in 0..<rhs.columns {
                for k in 0..<lhs.columns {
                    result[i][j] += lhs[i][k] * rhs[k][j]
                }
            }
        }
        
        return result
    }
    
    /// Computes the dot product of this matrix with another matrix.
    ///
    /// The function calculates the dot product by multiplying corresponding elements and summing the results.
    /// This operation is only valid when the number of columns in the first matrix equals the number of rows in the second matrix.
    ///
    /// - Parameter other: Another `MLMatrix` instance to compute the dot product with.
    /// - Returns: A scalar value of type `T` representing the dot product of the two matrices, or `nil` if the matrices do not have compatible dimensions.
    func dot(_ other: MLMatrix<T>) -> T? {
        precondition(self.columns == other.rows, "Matrix dimensions must be equal")

        var result: T = T.zero
        for i in 0..<self.rows {
            for j in 0..<other.columns {
                result += self[i][j] * other[j][i]
            }
        }

        return result
    }

    
    
}




// Subscript definitions

extension MLMatrix {
    subscript(row: Int, column: Int) -> T {
        get {
            return grid[row][column]
        }
        set {
            grid[row][column] = newValue
        }
    }
    
    subscript(row: Int) -> [T] {
        get {
            return grid[row]
        }
        set {
            grid[row] = newValue
        }
    }
}

// Matrix-Vector operations

extension MLMatrix {
}
