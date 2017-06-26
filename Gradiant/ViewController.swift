//
//  ViewController.swift
//  Gradiant
//
//  Created by Arqam Butt on 22/06/2017.
//  Copyright © 2017 Arqam Butt. All rights reserved.
//

import UIKit
import NVActivityIndicatorView



class ViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var gradiantView: UIViewX!
    var currentColorArrayIndex = -1
    
    var colorArray: [(color1: UIColor, color2: UIColor)] = []
    let green = #colorLiteral(red: 0.03529411765, green: 0.6666666667, blue: 0.6901960784, alpha: 1)
    let seeGreen = #colorLiteral(red: 0, green: 0.8039215686, blue: 0.6745098039, alpha: 1)
    let blue = #colorLiteral(red: 0.1294117647, green: 0.5764705882, blue: 0.6901960784, alpha: 1)
    let blueLight = #colorLiteral(red: 0.03137254902, green: 0.3137254902, blue: 0.4705882353, alpha: 1)
    let blueTone = #colorLiteral(red: 0.2666666667, green: 0.6274509804, blue: 0.5529411765, alpha: 1)
    let greenTone = #colorLiteral(red: 0.2352941176, green: 0.8274509804, blue: 0.6784313725, alpha: 1)
    
    @IBOutlet weak var pleaseWait: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorArray.append((color1: #colorLiteral(red: 0, green: 0.8039215686, blue: 0.6745098039, alpha: 1) , color2: #colorLiteral(red: 0.03529411765, green: 0.6666666667, blue: 0.6901960784, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.1294117647, green: 0.5764705882, blue: 0.6901960784, alpha: 1) , color2: #colorLiteral(red: 0.4274509804, green: 0.8352941176, blue: 0.9294117647, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.2980392157, green: 0.7215686275, blue: 0.768627451, alpha: 1) , color2: #colorLiteral(red: 0.2352941176, green: 0.8274509804, blue: 0.6784313725, alpha: 1)))
        
        gradiantView.alpha = 0.5
        animateBackgroundColor()
        aminateLoading()
        
        let subView =  Bundle.main.loadNibNamed("ContactDriver", owner: self.view, options: nil)?.first as! contactDriver
            subView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height/2.3)
            subView.contactLabel.alpha = 0
            UIView.animate(withDuration: 1, animations: {
                subView.frame.origin.y -= 400
            }){ (true) in
                UIView.animate(withDuration: 2, animations: {subView.contactLabel.alpha = 1})
            }
        mainView.addSubview(subView)
        
    }
    
    func aminateLoading(){
        
        let xx = self.view.frame.width / 2
        let yy = self.view.frame.height / 2
        
        animateLabel()
        let u =  NVActivityIndicatorView(frame:  CGRect(x: xx - 60, y: yy - 60, width: 120, height: 120), type: .orbit, color: UIColor.black, padding: 2.0)
        u.startAnimating() // layer speed can be control within the function
        self.view.addSubview(u)
    }
    
    func animateLabel() {
        
        UIView.animate(withDuration: 2.0, animations: {
        self.pleaseWait.alpha = 0
        }) { (true) in
            UIView.animate(withDuration: 2.0, animations: {
                self.pleaseWait.alpha = 1
            }, completion: { (true) in
                
                self.animateLabel()
            })
        }
    }
    
    func animateBackgroundColor(){
       
        currentColorArrayIndex = currentColorArrayIndex == (colorArray.count - 1) ? 0 : currentColorArrayIndex + 1
        UIView.transition(with: self.gradiantView, duration: 8, options: [.transitionCrossDissolve], animations: {
            self.gradiantView.firstColor = self.colorArray[self.currentColorArrayIndex].color1
            self.gradiantView.secondColor = self.colorArray[self.currentColorArrayIndex].color2
        }) {(success) in
            self.animateBackgroundColor()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

}




class UIViewX: UIView{

   @IBInspectable var firstColor: UIColor = UIColor.white{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.white{
        didSet{
            updateView()
        }
    }

    var horizontalGradiant: Bool = false {
        didSet{
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
               return CAGradientLayer.self
    }
    
    func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        
        if (horizontalGradiant){
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 0.5, y: 0.0)
        }else{
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
        
    }
    
    
}
