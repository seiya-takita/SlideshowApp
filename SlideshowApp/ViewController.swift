//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 滝田　勢也 on 2023/03/09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    private let playButtonText = "再生"
    private let pauseButtonText = "停止"
    
    private var timer: Timer!
    
    private var imageList: [UIImage] = []
    
    private var selectedIndex = 0
    
    private var isPlayingSlideshow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadImage()
        
        imageView.image = imageList[selectedIndex]
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:))))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let expandedImageViewController: ExpandImageViewController = segue.destination as! ExpandImageViewController
        
        expandedImageViewController.image = imageList[selectedIndex]
    }
    
    private func loadImage() {
        imageList.append(UIImage(named: "ramenImage1.jpg")!)
        imageList.append(UIImage(named: "ramenImage2.jpg")!)
        imageList.append(UIImage(named: "ramenImage3.jpg")!)
    }
    
    @objc func updateSlide(_ timer: Timer) {
        if selectedIndex == imageList.endIndex - 1  {
            selectedIndex = imageList.startIndex
            imageView.image = imageList[selectedIndex]
            return
        }
        
        selectedIndex += 1
        imageView.image = imageList[selectedIndex]
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "toExpandImageView", sender: nil)
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
    
    @IBAction func onTouchPlayButton(_ sender: Any) {
        if isPlayingSlideshow {
            timer.invalidate()
            timer = nil
            
            isPlayingSlideshow = false
            playButton.setTitle(playButtonText, for: .normal)
            
            nextButton.isEnabled = true
            previousButton.isEnabled = true
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateSlide(_:)), userInfo: nil, repeats: true)
        
        isPlayingSlideshow = true
        playButton.setTitle(pauseButtonText, for: .normal)
        
        nextButton.isEnabled = false
        previousButton.isEnabled = false
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
}

