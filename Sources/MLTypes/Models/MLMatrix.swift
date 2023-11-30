//
//  MLMatrix.swift
//  
//
//  Created by Ivan Sanchez on 28/11/23.
//

import Foundation

struct MLMatrix<T> where T: Randomizable, T: Numeric {
    var grid: [[T]]
    
    var rows: Int { return grid.count }
    var columns: Int { return grid[0].count }
    
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
    
    func column(_ index: Int) -> [T] {
        return (0..<self.rows).map { self[$0][index] }
    }
    
    // Matrix operations
    
    func transpose() -> MLMatrix<T> {
        var result = MLMatrix<T>(rows: self.columns, columns: self.rows)
        
        for i in 0..<self.rows {
            for j in 0..<self.columns {
                result[j][i] = self[i][j]
            }
        }
        
        return result
    }
    
    // Element-wise operations
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
    
    func dot(_ other: MLMatrix<T>) -> T {
        precondition(self.rows == 1 && self.columns == other.rows && other.columns == 1, "Matrix dimensions must be equal")
        return zip(self[0], other.column(0)).map(*).reduce(T.zero, +)
    }
    
    // MARK: - Matrix-Vector operations
    
    public init(from vector: MLVector<T>) {
        self.grid = vector.map { $0 }
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
