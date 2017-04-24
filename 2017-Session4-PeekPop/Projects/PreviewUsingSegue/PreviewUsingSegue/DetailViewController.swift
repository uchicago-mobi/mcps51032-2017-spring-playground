/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    The detail view controller.
*/

import UIKit

class DetailViewController: UIViewController {
    // MARK: Properties

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    // Property to hold the detail item's title.
    var sampleTitle: String?
    
    // Preview action items.
    lazy var previewActions: [UIPreviewActionItem] = {
        func previewActionForTitle(_ title: String, style: UIPreviewActionStyle = .default) -> UIPreviewAction {
            return UIPreviewAction(title: title, style: style) { previewAction, viewController in
                guard let detailViewController = viewController as? DetailViewController,
                          let sampleTitle = detailViewController.sampleTitle else { return }
                
                print("\(previewAction.title) triggered from `DetailViewController` for item: \(sampleTitle)")
            }
        }
        
        let action1 = previewActionForTitle("Default Action")
        let action2 = previewActionForTitle("Destructive Action", style: .destructive)
        
        let subAction1 = previewActionForTitle("Sub Action 1")
        let subAction2 = previewActionForTitle("Sub Action 2")
        let groupedActions = UIPreviewActionGroup(title: "Sub Actions…", style: .default, actions: [subAction1, subAction2] )
        
        return [action1, action2, groupedActions]
    }()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update the user interface for the detail item.
        if let sampleTitle = sampleTitle {
            detailDescriptionLabel.text = sampleTitle
        }
        
        // Set up the detail view's `navigationItem`.
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }
    
    // MARK: Preview actions

    override var previewActionItems : [UIPreviewActionItem] {
        return previewActions
    }
}
