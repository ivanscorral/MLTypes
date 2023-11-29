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
    
    public init(grid: [[T]]) {
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
    
    // Matrix operations
    
    func transpose() -> MLMatrix<T> {
        var result = [[T]](repeating: [T](repeating: T.zero, count: self.rows), count: self.columns)
        
        for i in 0..<self.rows {
            for j in 0..<self.columns {
                result[j][i] = self.grid[i][j]
            }
        }
        
        return MLMatrix(grid: result)
    }
    
    // Element-wise operations
    func map(_ transform: (T) -> T) -> MLMatrix<T> {
        var result = [[T]](repeating: [T](repeating: T.zero, count: self.columns), count: self.rows)
        
        for i in 0..<self.rows {
            for j in 0..<self.columns {
                result[i][j] = transform(self.grid[i][j])
            }
        }
        
        return MLMatrix(grid: result)
    }
    
    
}
