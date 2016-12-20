//
//  ViewController.swift
//  Camera
//
//  Created by Niu Panfeng on 24/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
//import MediaPlayer
import AVKit
import AVFoundation
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var takePictureButton: UIButton!
    @IBOutlet weak var selectPictureButton: UIButton!
    var moviePlayerController:AVPlayerViewController?
    var lastChosenMediaType: String?
    var image: UIImage?
    var movieURL: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            takePictureButton.hidden = true
        }
    }
    //每次显示视图时候调用
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("==========================================")
        print(__FUNCTION__)
        updateDisplay()
    }
    //更新界面显示
    func updateDisplay() {
        if let mediaType = lastChosenMediaType
        {
            print("==========================================")
            print(__FUNCTION__)
            print("mediaType:\(mediaType)")
            if mediaType == kUTTypeImage as NSString
            {
                if moviePlayerController != nil
                {
                    moviePlayerController!.view.hidden = true
                }
                
                imageView.image = image!
                imageView.hidden = false
            }
            else if mediaType == kUTTypeMovie as NSString
            {
                if moviePlayerController == nil
                {
                    let avPlayer = AVPlayer(URL: movieURL!)
                    moviePlayerController = AVPlayerViewController()
                    moviePlayerController!.player = avPlayer
                    moviePlayerController!.view.frame = imageView.frame
                    moviePlayerController!.view.clipsToBounds = true
                    self.view.addSubview(moviePlayerController!.view)
                    setMoviePlayerLayoutConstraints()
                    avPlayer.play()
                }
                else
                {
                    let avPlayer = AVPlayer(URL: movieURL!)
                    moviePlayerController!.player = avPlayer
                    avPlayer.play()
                }
                
                imageView.hidden = true
                moviePlayerController!.view.hidden = false
                
            }
        
        }
    }
    //设置视频播放器的布局约束
    func setMoviePlayerLayoutConstraints() {
        let moviePlayerView = moviePlayerController!.view
        moviePlayerView.translatesAutoresizingMaskIntoConstraints = false
        let myViews = ["moviePlayerView": moviePlayerView, "takePictureButton": takePictureButton, "selectPictureButton": selectPictureButton, "topLayoutGuide": self.topLayoutGuide, "bottomLayoutGuide": self.bottomLayoutGuide]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[moviePlayerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: myViews as! [String : AnyObject] ))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[topLayoutGuide]-8-[moviePlayerView]-8-[takePictureButton]-8-[selectPictureButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: myViews as! [String : AnyObject] ))
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //--------------------------------------------------------------------
    //从摄像头中pick
    @IBAction func shootPictureOrVideo(sender: UIButton) {
        pickMediaFromSource(UIImagePickerControllerSourceType.Camera)
    }
    //从照片库中pick
    @IBAction func selectExistingPictureOrVideo(sender: UIButton) {
        pickMediaFromSource(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    //从指定媒体库源中读取Media,并显示出来
    func pickMediaFromSource(sourceType: UIImagePickerControllerSourceType) {
        
        if moviePlayerController != nil
        {
            moviePlayerController?.player?.pause()
        }
        
        let mediaType = UIImagePickerController.availableMediaTypesForSourceType(sourceType)!
        if UIImagePickerController.isSourceTypeAvailable(sourceType) && mediaType.count > 0
        {
            //媒体库可用，并且媒体类型种类数目大于0
            print("==========================================")
            print("mediaType:\(mediaType)")
            let picker = UIImagePickerController()
            picker.sourceType = sourceType//媒体库源类型
            picker.mediaTypes = mediaType //媒体类型
            picker.delegate = self
            picker.allowsEditing = true
            presentViewController(picker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Error accessing media", message: "Unsupported media source", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    //--------------------------------------------------------------------
    //MARK:--UIImagePickerControllerDelegate代理方法
    //选取了照片或视频之后，记录选取的照片或视频
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        lastChosenMediaType = info[UIImagePickerControllerMediaType] as? String
        print("==========================================")
        print("lastChosenMediaType:\(lastChosenMediaType)")
        print("kUTTypeImage:\(kUTTypeImage)")
        if let mediaType = lastChosenMediaType
        {
            if mediaType == kUTTypeImage as NSString {
                image = info[UIImagePickerControllerEditedImage] as? UIImage
            } else if mediaType == kUTTypeMovie as NSString {
                movieURL = info[UIImagePickerControllerMediaURL] as? NSURL
            }
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    //放弃了选取照片或视频后的操作
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }


}

