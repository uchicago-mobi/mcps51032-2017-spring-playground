# UIKit Catalog (tvOS): Creating and Customizing UIKit Controls

Demonstrates how to use many views and controls in the UIKit framework on tvOS. Refer to this sample if you are looking for specific controls or views that are provided by the system.

## Requirements

### Build

Xcode 8.0 and tvOS 10.0 SDK or later

### Runtime

tvOS 10.0 or later

## Using the sample

This sample can be run on a device or on the simulator.

This sample uses a tab bar controller based application architecture, which can be seen in the Main.storyboard file. Each tab demonstrates different aspects of working with UIKit on tvOS.

With the exception of the "Focus" and "Search" tabs, each tab displays a split view controller. Each of these split view controllers contain a static table view controller as its master view controller.

The master table view controller of each split view is a subclass of MenuTableViewController. This class is responsible for updating the containing split view controller's detail view as the focus changes within the table view. If the user clicks to select a table view row, the table view controller asks its containing split view controller to move the focus to its detail view controller.

### Controls

The "Controls" tab demonstrates various UIKit controls and how they can be customized.

+ ButtonsViewController - demonstrates how to use UIButton.
+ ProgressViewController - demonstrates how to use UIProgressView.
+ SegmentedControlsViewController - demonstrates how to use UISegmentedControl.

### View Controllers

The "View Controllers" tab demonstrates how to use some of the UIViewController subclasses available in UIKit on tvOS.

+ AlertsViewController - demonstrates how to use UIAlertController.
+ CollectionViewController - demonstrates how to use a UICollectionViewController. A custom UIView subclass, GradientMaskView, is used to mask the contents of the collection view as it scrolls beneath the containing UINavigationController's UINavigationBar.
+ PageViewController - demonstrates how to use UIPageViewController.

### Text Entry

The "Text Entry" tab shows some of the different text input options available in UIKit on tvOS.

+ TextEntry.storyboard - contains a view controller that demonstrates the different types of keyboard that are available by configuring UITextField objects.
+ AlertFormViewController - demonstrates how to implement text entry using UIAlertController.

### Focus

Focus is an important concept to tvOS and the "Focus" tab demonstrates a few common ways in which the default focus implementation needs to be altered to achieve the behavior the user expects.

+ CollectionViewContainerViewController - demonstrates how to ensure focus behaves correctly when a UICollectionView's cells contain their own instance of a UICollectionView.
+ FocusGuidesViewController - demonstrates how to use UIFocusGuides to ensure focus moves correctly between controls in situations where the default focus behavior may not be sufficient.

### Top Shelf items

The sample contains a TV Services extension. This extension contains a class, ServiceProvider, that implements the TVTopShelfProvider protocol to provide TVContentItems to show on the Top Shelf.

Copyright (C) 2016 Apple Inc. All rights reserved.
