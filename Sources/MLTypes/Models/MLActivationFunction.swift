//
//  File.swift
//  
//
//  Created by Ivan Sanchez on 30/11/23.
//

import Foundation

/// A protocol defining an activation function for use in neural networks.
public protocol ActivationFunction {
    /// Applies the activation function to the given input.
    /// - Parameter x: The input value to the function.
    /// - Returns: The output of the activation function for the input value.
    func apply(_ x: Double) -> Double
    
    /// Calculates the derivative of the activation function at a given point.
    /// Depending on the activation function, `x` could be the raw input value or the output from `apply`.
    /// - Parameter x: The value for which the derivative is calculated, this might be the input or the output of `apply`.
    /// - Returns: The derivative of the activation function at the given value.
    func derivative(_ x: Double) -> Double
}

/// An implementation of the sigmoid activation function.
public struct Sigmoid: ActivationFunction {
    
    /// Applies the sigmoid function to an input value.
    /// - Parameter x: The input value to the sigmoid function.
    /// - Returns: The calculated output using the sigmoid function.
    public func apply(_ x: Double) -> Double {
        return 1 / (1 + exp(-x))
    }
    
    /// Calculates the derivative of the sigmoid function at a given input value.
    /// It uses the sigmoid function's property that its derivative can be expressed using the output value σ(x) as σ(x) * (1 - σ(x)).
    /// - Parameter x: The input value for which to calculate the derivative.
    /// - Returns: The derivative of the sigmoid function at the given input value.
    public func derivative(_ x: Double) -> Double {
        let sigmoidOutput = apply(x)
        return sigmoidOutput * (1 - sigmoidOutput)
    }
}

/// An implementation of the Rectified Linear Unit (ReLU) activation function.
public struct ReLu: ActivationFunction {
    
    /// Applies the ReLU function to an input value.
    /// - Parameter x: The input value to the ReLU function.
    /// - Returns: The output of the ReLU function which is the max of 0 and input value.
    public func apply(_ x: Double) -> Double {
        return max(0, x)
    }
    
    /// Calculates the derivative of the ReLU function for a given input.
    /// - Parameter x: The input value for which the derivative is calculated.
    /// - Returns: The derivative of the ReLU function which is 1 if input is positive, otherwise 0.
    public func derivative(_ x: Double) -> Double {
        return x > 0 ? 1 : 0
    }
}

/// An implementation of the hyperbolic tangent (tanh) activation function.
public struct Tanh: ActivationFunction {
    
    /// Applies the hyperbolic tangent function to an input value.
    /// - Parameter x: The input value to the tanh function.
    /// - Returns: The output of the tanh function for the input value.
    public func apply(_ x: Double) -> Double {
        return tanh(x)
    }
    
    /// Calculates the derivative of the tanh function at a given input value.
    /// This implementation applies the derivative formula directly.
    /// - Parameter x: The input value for the tanh function.
    /// - Returns: The derivative of the tanh function at the input value.
    public func derivative(_ x: Double) -> Double {
        return 1 - x * x
    }
}
