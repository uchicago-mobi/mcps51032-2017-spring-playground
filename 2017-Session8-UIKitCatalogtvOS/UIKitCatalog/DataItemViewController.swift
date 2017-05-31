/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A view controller that displays the image for a `DataItem`. An instance of this class is created for each page of `PageViewController`.
*/

import UIKit

class DataItemViewController: UIViewController {
    // MARK: Properties
    
    static let storyboardIdentifier = "DataItemViewController"

    @IBOutlet var imageView: UIImageView!
    
    private(set) var dataItem: DataItem!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = UIImage(named: dataItem.largeImageName) {
            imageView.image = image
        }
        else {
            imageView.image = UIImage(named: dataItem.imageName)
        }
    }
    
    // MARK: Convenience
    
    func configure(with dataItem: DataItem) {
        self.dataItem = dataItem
    }
}
