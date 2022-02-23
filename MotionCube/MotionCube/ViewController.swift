//
//  ViewController.swift
//  MotionCube
//
//  Created by George Tevosov on 16.02.2022.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var dynamicAnimator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var itemBehaviour: UIDynamicItemBehavior!
    var shapes: [Shape] = []
    var selected: Shape?
    let motion = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(sender:)))
        collision = UICollisionBehavior(items: [])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        self.gravityBehavior = UIGravityBehavior()
        gravityBehavior.magnitude = 3
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: view)
        dynamicAnimator.addBehavior(gravityBehavior)
        dynamicAnimator.addBehavior(collision)
        
        self.itemBehaviour = UIDynamicItemBehavior()
        self.itemBehaviour.elasticity = 0.5
        dynamicAnimator.addBehavior(self.itemBehaviour)
        
        view.addGestureRecognizer(gesture)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.shapePan(sender:)))
        view.addGestureRecognizer(panGestureRecognizer)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action:
                                                        #selector(shapePinch(sender:)))
        view.addGestureRecognizer(pinchGesture)
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(shapeRotation(sender:)))
        view.addGestureRecognizer(rotationGesture)
        
        if (motion.isAccelerometerAvailable) {
            motion.accelerometerUpdateInterval = 0.2
            motion.startAccelerometerUpdates(to: OperationQueue.main) {
                (data, error) in
                if (error == nil && data != nil)
                {
                    self.gravityBehavior.gravityDirection = CGVector(dx: data!.acceleration.x, dy: -data!.acceleration.y)
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        motion.stopAccelerometerUpdates()
    }
    
    @objc func tapGesture(sender: UITapGestureRecognizer) {
        guard findView(sender: sender) != nil else
        {
            if sender.state == .ended {
                addElement(pos: sender.location(in: view))
                print(sender.location(in: view))
            }
            selected = nil;
            return
        }
    }
    
    func addElement(pos: CGPoint) {
        let shape = Shape(x: Int(pos.x), y: Int(pos.y), width: 100, height: 100)
        shape.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(shape)
        shapes.append(shape)
        gravityBehavior.addItem(shape)
        collision.addItem(shape)
        itemBehaviour.addItem(shape)
     
    }
    
    func findView(sender: UIGestureRecognizer) -> Shape? {
        let pos = sender.location(in: self.view)
        for shape in self.shapes {
            if (shape.layer.presentation()?.frame.contains(pos))!{
                return shape
            }
        }
        return nil
    }
    
    @objc func shapePan(sender: UIPanGestureRecognizer) {
        guard let res = findView(sender: sender) else {return}
        switch sender.state {
        case.began:
            self.view.bringSubviewToFront(res)
            self.gravityBehavior.removeItem(res)
            print(sender.location(in: self.view))
        case .changed:
            res.center = sender.location(in: self.view)
            print (view.center)
            self.dynamicAnimator.updateItem(usingCurrentState: res)
        case .ended:
            self.gravityBehavior.addItem(res)
        default:
            print("default")
        }
    }
    
    @objc func shapePinch(sender: UIPinchGestureRecognizer) {
        //        if (selected == nil) { return }
        //        let res = findView(sender: sender)
        //        print (res)
        //        if (res == -1) {return};
        //        let view = self.view.subviews[res]
        switch sender.state {
        case.began:
            selected = findView(sender: sender)
            if (selected != nil) {
                print("removed item")
                collision.removeItem(selected!)
                gravityBehavior.removeItem(selected!)
                itemBehaviour.removeItem(selected!)
            }
        case.changed:
            if (selected == nil)
                {return};
            selected!.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
//            selected!.transform = (selected!.transform.scaledBy(x: sender.scale, y: sender.scale))
            selected!.bounds = selected!.frame
            if (selected?.shape == ShapeType.circle) {
                selected!.layer.cornerRadius = CGFloat(selected!.bounds.width / 2)
                selected!.layer.masksToBounds = true
            }
        case .ended:
            if (selected != nil) {
                print("ended")
                dynamicAnimator.updateItem(usingCurrentState: selected!)
                gravityBehavior.addItem(selected!)
                collision.addItem(selected!)
                itemBehaviour.addItem(selected!)
                selected = nil
            }
        default:
            print("default")
        }
        sender.scale = 1.0
        
    }
    
    @objc func shapeRotation(sender: UIPanGestureRecognizer) {
    }
}

