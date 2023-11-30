# MLTypes

## Overview

`MLTypes` is a Swift package offering advanced types and extensions for machine learning applications. Focused on providing robust, Swift-native implementations for vectors and matrices, it includes extensions for standard types, enhancing their functionality in ML scenarios.

## Features

- `MLVector`: Generic vector implementation with customizable element types. Supports initialization, element manipulation, and ML-specific operations.
- `MLMatrix`: Generic matrix structure to represent and manipulate 2D data arrays in ML models.
- `Randomizable` Protocol: Allows for the random initialization of numeric types, vital for stochastic aspects of ML algorithms.
- `IntegerExtensions` & `FloatingPointExtensions`: Extend native Swift types to fit into ML contexts seamlessly.

## Roadmap

- **Performance Optimization**: Refine current implementations for better performance, especially for large-scale data.
- **Advanced Operations**: Introduce more complex vector and matrix operations, like dot product, cross product, matrix inversion, etc.
- **ML Algorithms Integration**: Facilitate integration with common ML algorithms, possibly collaborating with other ML frameworks.
- **Documentation & Examples**: Expand documentation with more examples and use cases.
- **Testing & Validation**: Develop a comprehensive test suite to ensure reliability and accuracy.

## Installation

[Provide installation instructions here]

## Usage

### Initializing Matrices and Vectors

```swift
let matrix1: MLMatrix<Int> = MLMatrix(rows: 2, columns: 3, defaultValue: 5) // Type definition is optional
let matrix2 = MLMatrix([[1, 2, 3], [4, 5, 6]])

let vector1: MLVector<Int> = MLVector([1, 2, 3])
let vector2 = MLVector(repeating: 4, size: 3)
```

### Matrix Operations

```swift
let transposedMatrix = matrix1.transpose() // Transpose a matrix
let matrixSum = matrix1 + matrix2 // Add two matrices
let productVector: MLVector<Int> = matrix1 * vector1 // Multiply a matrix by a vector (type definition not required)
```

### Vector Operations

```swift
let vectorSum = vector1 + vector2 // Vector addition
let dotProduct = vector1.dot(vector2) // Dot product of two vectors
let scaledVector = vector1.scale(by: 2) // Vector scaling
```

### Advanced Operations

```swift
let rowDotProduct = matrix1.dot(with: vector1, atRow: 0) // Dot product of a matrix row and a vector
let vectorMatrixProduct = vector1 * matrix2 // Multiplication of a vector by a matrix
```

## Contributing

Contributions are welcome, especially in areas like performance optimization, expanding mathematical operations, and improving integration with ML algorithms. Please follow the [contributing guidelines](LINK_TO_CONTRIBUTING_GUIDELINES).
