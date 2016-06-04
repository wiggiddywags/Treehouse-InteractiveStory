//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Josh Waggoner on 5/27/16.
//  Copyright © 2016 60watts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    
    
    enum Error : ErrorType {
        case NoName
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startAdventure" {
            
            
            do {
                if let name = nameTextField.text {
                    if name == "" {
                        throw Error.NoName
                    }
                    if let pageController = segue.destinationViewController as? PageController {
                        pageController.page = Adventure.story(name)
                    }
                }
            } catch Error.NoName{
                let alertController = UIAlertController(title: "Name Not Provided", message: "Provide a name to start your story", preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alertController.addAction(action)
                presentViewController(alertController, animated: true, completion: nil)
            } catch let error{
                fatalError("\(error)")
            }
            
        }
    }
    
    func keyboardWillShow(notification : NSNotification) {
        
        if let userInfoDict = notification.userInfo, keyboardFrameValue = userInfoDict[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardFrameValue.CGRectValue()
            
            UIView.animateWithDuration(0.8) {
                self.textFieldBottomConstraint.constant = keyboardFrame.size.height + 10
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }


}

