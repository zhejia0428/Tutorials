//
//  GameViewController.swift
//  DesignPatternsInSwift
//
//  Created by Joel Shapiro on 9/23/14.
//  Copyright (c) 2014 RepublicOfApps, LLC. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


class GameViewController: UIViewController {

  fileprivate var gameView: GameView { return view as! GameView }
  fileprivate var shapeFactory: ShapeFactory!
  fileprivate var shapeViewFactory: ShapeViewFactory!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.shapeFactory = SquareShapeFactory(minProportion: 0.3, maxProportion: 0.8)
    self.shapeViewFactory = SquareShapeViewFactory(size: gameView.sizeAvailableForShapes())
    beginNextTurn()
  }

  override var prefersStatusBarHidden : Bool {
    return true
  }

  fileprivate func beginNextTurn() {

    let shapes = self.shapeFactory.createShapes()
    let shapeViews = self.shapeViewFactory.makeShapeViewsforShapes(shapes: shapes)

    shapeViews.0.tapHandler = {
      tappedView in
      self.gameView.score += shapes.0.area >= shapes.1.area ? 1 : -1
      self.beginNextTurn()
    }
    shapeViews.1.tapHandler = {
      tappedView in
      self.gameView.score += shapes.1.area >= shapes.0.area ? 1 : -1
      self.beginNextTurn()
    }

    gameView.addShapeViews(shapeViews)
  }
}
