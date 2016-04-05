//
//  ViewController.swift
//  SocialSharingTemplate
//
//  Created by Saurav Aryal on 4/5/16.
//  Copyright © 2016 Saurav Aryal. All rights reserved.
//

import UIKit

import Social

class ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @IBOutlet weak var shareTextBtn: UIButton!
    @IBOutlet weak var textToShare: UITextField!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var FbShareBtn: UIButton!
    
    var singleTap:UITapGestureRecognizer!
    var imagePicker = UIImagePickerController()
    var activityViewController:UIActivityViewController?
    
    @IBAction func shareTextBtnClicked(sender: AnyObject) {
        let activityViewController = UIActivityViewController(
            activityItems: [textToShare.text! as NSString],
            applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func FBShareBtnClicked(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText(textToShare.text! as String)
            facebookSheet.addImage(imgView.image);
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }


    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textToShare.delegate = self
        shareTextBtn!.layer.borderWidth = 1.1
        shareTextBtn!.layer.borderColor = UIColor.blueColor().colorWithAlphaComponent(0.6).CGColor
        shareTextBtn!.layer.cornerRadius = 4.5
        
        initializeImagePicker()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func initializeImagePicker() {
        imagePicker.delegate = self
        
        singleTap = UITapGestureRecognizer(target: self, action: "clickPickImageFromGallery")
        singleTap.numberOfTapsRequired = 1
        
        imgView.userInteractionEnabled = true
        imgView.addGestureRecognizer(singleTap)
        
        imgView.layer.borderWidth = 2
        imgView.layer.borderColor = UIColor.grayColor().CGColor
        
        FbShareBtn!.layer.borderWidth = 1.0
        FbShareBtn!.layer.borderColor = UIColor.blueColor().colorWithAlphaComponent(0.5).CGColor
        FbShareBtn!.layer.cornerRadius = 5.0
    }
    
    
    func clickPickImageFromGallery(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = true
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("User cancelled")
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        print("User selected image: editingInfo \(editingInfo) Image \(image)")
        
        imgView.image = image
        
    }


}

