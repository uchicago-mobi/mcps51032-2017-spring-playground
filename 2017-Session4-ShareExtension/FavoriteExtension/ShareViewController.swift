//
//  ShareViewController.swift
//  FavoriteExtension
//
//  Created by T. Andrew Binkowski on 4/21/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import UIKit
import Social
import ExtensionKit
import MobileCoreServices

/// View Controller that is presented via the share extension.  This uses the 
/// default share sheet from the `Social.framework`.
class ShareViewController: SLComposeServiceViewController {
  
  /// Hold the app icon
  var imageToShare: UIImage?
  /// Hold the app store URL
  var urlToShare: String?
  /// Hold the application title
  var textToShare: String?
  

  //
  // MARK: - Share extension methods
  //
  
  override func presentationAnimationDidFinish() {
    let items = extensionContext?.inputItems
    var itemProvider: NSItemProvider?
    
    // Exit early if there are no items
    if items == nil && items!.isEmpty != false { return }

    // Get item
    let item = items![0] as! NSExtensionItem
    print("Attachment items: \(String(describing: items))")
    
    // Loop through all the attachment items and store their values in properties
    //
    // Note: The App Store makes three attachements available: image, plain-text, and url
    //
    
    if let attachments = item.attachments {
      
      for attachment in attachments {
        itemProvider = attachment as? NSItemProvider
        
        // Get text
        let textType = kUTTypePlainText as String
        if itemProvider?.hasItemConformingToTypeIdentifier(textType) == true {
          itemProvider?.loadItem(forTypeIdentifier: textType, options: nil) { (item, error) -> Void in
            if error == nil {
              if let text = item as? String {
                print("🌎 Text: \(text)")
                self.textToShare = text
              }
            }
          }
        }
        
        // Get URL
        let urlType = kUTTypeURL as String
        if itemProvider?.hasItemConformingToTypeIdentifier(urlType) == true {
          itemProvider?.loadItem(forTypeIdentifier: urlType, options: nil) { (item, error) -> Void in
            if error == nil {
              if let url = item as? URL {
                print("🌎 URL: \(url)")

                self.urlToShare = url.absoluteString
              }
            }
          }
          
        }
        
        // Get image
        let imageType = kUTTypeImage as String
        if itemProvider?.hasItemConformingToTypeIdentifier(imageType) == true {
          itemProvider?.loadItem(forTypeIdentifier: imageType, options: nil) { (item, error) -> Void in
            if error == nil {
              if let image = item as? UIImage {
                self.imageToShare = image
                print("🌎 Image: \(String(describing: item))")
              }
            }
          }
        }
        
      }
    }
    
  }
  

  
  override func didSelectPost() {
    // This is called after the user selects Post. Do the upload of
    // contentText and/or NSExtensionContext attachments.
    
    // While it is possible to save an UIImage to a dictionary as NSData as
    // we are doing here, it is generally not a good idea.  You could store
    // image on server or in App Group folder and keep the URL of the location
    // to store
    
    // Also, note that you get the app store URL, so you could use it to get
    // the image that way.
    let imageData: Data? = UIImagePNGRepresentation(imageToShare!)
    let sharedItem: NSDictionary = [ "date": Date(),
                                     "contentText": textToShare!,
                                     "imageData": imageData!,
                                     "url": urlToShare!
    ]
    
    LocalDefaultsManager.sharedInstance.add(object: sharedItem)
    
    
    // Inform the host that we're done, so it un-blocks its UI.
    // Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
  }
  
  
  
  override func isContentValid() -> Bool {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return true
  }
  
  
  override func configurationItems() -> [Any]! {
    // To add configuration options via table cells at the bottom of the sheet,
    // return an array of SLComposeSheetConfigurationItem here.
    return []
  }
}
