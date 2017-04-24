/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    An extension on UINavigationController to return the top view controller's previewActionItems by default.
*/

import UIKit

extension UINavigationController {
    /*
        Override the default implementation of `previewActionItems` to return the
        preview items for the controller's `topViewController`.
    */
    open override var previewActionItems : [UIPreviewActionItem] {
        if let items = self.topViewController?.previewActionItems {
            return items
        }
        else {
            return super.previewActionItems
        }
    }
}
