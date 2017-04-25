//
//  SVNModalViewController.swift
//  Tester
//
//  Created by Aaron Dean Bikis on 4/11/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNTheme
import SVNShapesManager

/**
 A modal viewController to be subclassed. Contains a Top Left dismissButton and uses *SVNShapesManager* & *SVNTheme*
    To add the button on the top left call addModalSubviews in viewDidLoad
    Be sure that this viewController is presented modally otherwise override *shouldDismiss*
 */
open class SVNModalViewController: UIViewController {
    
    private lazy var dismissMeta: SVNShapeMetaData = {
        let shape = SVNShapeMetaData(shapes: nil,
                                     location: .topLeft,
                                     padding: CGPoint(x: 10.0, y: 15.0),
                                     size: CGSize(width: 65.0, height: 65.0),
                                     fill: UIColor.clear.cgColor,
                                     stroke: self.theme.stanardButtonTintColor.cgColor,
                                     strokeWidth: 2.5)
        return shape
    }()
    
    public lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(SVNModalViewController.shouldDismiss), for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    open lazy var shapesManager: SVNShapesManager = {
        let manager = SVNShapesManager(container: self.view.bounds)
        return manager
    }()
    
    open var theme: SVNTheme = SVNTheme_DefaultDark()
    
    public func addModalSubviews(){
        self.dismissButton.frame = self.shapesManager.fetchRect(for: .topLeft, with: CGPoint(x: 0, y:0), and: CGSize(width: 85, height: 85))
        self.dismissMeta.shapes = self.shapesManager.createTwoLines(with: dismissMeta, shapeToCreate: .exit)
        self.dismissMeta.shapes?.forEach({ self.view.layer.addSublayer($0) })
    }
    
    open func shouldDismiss(){
        self.dismiss(animated: true, completion: nil)
    }
}
