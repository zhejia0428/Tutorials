//
//  ShapeFactory.swift
//  DesignPatternsInSwift
//
//  Created by Zhe Jia on 7/6/17.
//  Copyright © 2017 RepublicOfApps, LLC. All rights reserved.
//

import UIKit

protocol ShapeFactory {
  func createShapes() -> (Shape, Shape)
}

class SquareShapeFactory: ShapeFactory {
  var minProportion: CGFloat
  var maxProportion: CGFloat
  
  init(minProportion: CGFloat, maxProportion: CGFloat) {
    self.minProportion = minProportion
    self.maxProportion = maxProportion
  }
  
  func createShapes() -> (Shape, Shape) {
    let shape1 = SquareShape()
    let shape2 = SquareShape()
    
    shape1.sideLength = Utils.randomBetweenLower(minProportion, andUpper: maxProportion)
    shape2.sideLength = Utils.randomBetweenLower(minProportion, andUpper: maxProportion)
    
    return (shape1, shape2)
  }
}

class CircleShapeFactory: ShapeFactory {
  var minProportion: CGFloat
  var maxProportion: CGFloat
  
  init(minProportion: CGFloat, maxProportion: CGFloat) {
    self.minProportion = minProportion
    self.maxProportion = maxProportion
  }
  
  func createShapes() -> (Shape, Shape) {
    let shape1 = CircleShape()
    let shape2 = CircleShape()
    
    shape1.diameter = Utils.randomBetweenLower(self.minProportion, andUpper: self.maxProportion)
    shape2.diameter = Utils.randomBetweenLower(self.minProportion, andUpper: self.maxProportion)
    return (shape1, shape2)
  }
  
}
