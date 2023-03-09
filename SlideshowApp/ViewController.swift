//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 滝田　勢也 on 2023/03/09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    private var imageList: [UIImage] = []
    
    private var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadImage()
        
        imageView.image = imageList[selectedIndex]
    }
    
    private func loadImage() {
        imageList.append(UIImage(named: "ramenImage1.jpg")!)
        imageList.append(UIImage(named: "ramenImage2.jpg")!)
        imageList.append(UIImage(named: "ramenImage3.jpg")!)
    }
    
    @IBAction func onTouchNextButton(_ sender: Any) {
        if selectedIndex == imageList.endIndex - 1  {
            selectedIndex = imageList.startIndex
            imageView.image = imageList[selectedIndex]
            return
        }
        
        selectedIndex += 1
        imageView.image = imageList[selectedIndex]
    }
    
    @IBAction func onTouchPreviousButton(_ sender: Any) {
        if selectedIndex == imageList.startIndex  {
            selectedIndex = imageList.endIndex - 1
            imageView.image = imageList[selectedIndex]
            return
        }
        
        selectedIndex -= 1
        imageView.image = imageList[selectedIndex]
    }
    
}

