//
//  MLMatrix.swift
//  
//
//  Created by Ivan Sanchez on 28/11/23.
//

import Foundation

struct MLMatrix<T> where T: Randomizable, T: Numeric {
    var grid: [[T]]
}
