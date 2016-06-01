//
//  PageController.swift
//  InteractiveStory
//
//  Created by Josh Waggoner on 5/28/16.
//  Copyright © 2016 60watts. All rights reserved.
//

import UIKit

class PageController: UIViewController {
    
    var page : Page?
    let artwork = UIImageView()
    let storyLabel = UILabel()
    let firstChoiceBtn = UIButton(type: .System)
    let secondChoiceBtn = UIButton(type: .System)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(page: Page) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let page = page {
            artwork.image = page.story.artwork
            
            let attributedString = NSMutableAttributedString(string: page.story.text)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            
            storyLabel.attributedText = attributedString
            
            //if the firstChoice exists..
            if let firstChoice = page.firstChoice {
                firstChoiceBtn.setTitle(firstChoice.title, forState: .Normal)
                
            } else {
                firstChoiceBtn.setTitle("Play Again", forState: .Normal)
            }
            
            
            if let secondChoice = page.secondChoice {
                secondChoiceBtn.setTitle(secodChoice.title, forState: .Normal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillLayoutSubviews() {
        view.addSubview(artwork)
        artwork.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
                artwork.topAnchor.constraintEqualToAnchor(view.topAnchor),
                artwork.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
                artwork.rightAnchor.constraintEqualToAnchor(view.rightAnchor),
                artwork.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
            ])
        
        view.addSubview(storyLabel)
        storyLabel.translatesAutoresizingMaskIntoConstraints = false
        storyLabel.numberOfLines = 0 //letting story label figure how many lines we need
        
        NSLayoutConstraint.activateConstraints([
                storyLabel.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 16.0),
                storyLabel.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -16.0),
                storyLabel.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: 48.0)
            ])
        
        view.addSubview(firstChoiceBtn)
        firstChoiceBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            firstChoiceBtn.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            firstChoiceBtn.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -80.0)
            ])
        
        view.addSubview(secondChoiceBtn)
        secondChoiceBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([
            secondChoiceBtn.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            secondChoiceBtn.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -32)
            ])
        
    }
}
