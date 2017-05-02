# WatchKit Catalog: Using WatchKit Interface Elements

WatchKit Catalog is an exploration of the UI elements available in the WatchKit framework. Throughout the sample, you'll find tips and configurations that will help guide the development of your WatchKit app.

### Tips

- Notification schemes have been created for ease of switching between executables on the fly. In your projects, edit the WatchKit app scheme and change the Executable to the specific executable you'd like to run and debug. You can additionally create additional schemes, as this sample has.

- To debug notifications in the iOS Simulator, select the appropriate scheme in the Xcode toolbar and then Build and Run.

- ButtonDetailController has two examples of how to hide and show UI elements at runtime. First, tapping on button "1" will toggle the hidden property of button "2." When hiding the button, the layout will change to make use of the newly available space. When showing it again, the layout will change to make room for it. The second example is by setting the alpha property of button "2" to 0.0 or 1.0. Tapping on button "3" will toggle this and while button "2" may look invisible, the space it takes up does not change and no layout changes will occur.

- In ImageDetailController, note the comments where the "Walkway" image is being sent across to Apple Watch from the WatchKit Extension bundle. The animated image sequence is stored in the WatchKit app bundle. Comments are made throughout the sample project where images are used from one bundle or another.

- In the storyboard scene for GroupDetailController, note the use of nested groups to achieve more sophisticated layouts of images and labels. This is highly encouraged and will be necessary to achieve specific designs.

- TableDetailController has an example of inserting more rows into a table after the initial set of rows have been added to a table.

- ControllerDetailController shows how to present a modal controller, as well as how to present a controller that does not match the navigation style of your root controller. In this case, the WatchKit app has a hierarchical navigation style. Using the presentation of a modal controller though, we are able to present a page-based set of controllers.

- ControllerDetailController can present a modal controller. The "Dismiss" text of the modal controller is set in the Title field in the Attributes Inspector of the scene for PageController.

- TextInputController presents the text input controller with a set of suggestions. The result is sent to the parent iOS application and a confirmation message is sent back to the WatchKit app extension.

- MovieDetailController shows how to play videos either inline or modally/

- CrownDetailController demonstrates the crown API and how to use the focus method to mix crown and picker interactions in a single controller.

- GestureDetailController implements all 4 gesture types and how to hook up and use their action callbacks.

## Requirements

### Build

Xcode 8.0 or later; iOS 10.0 SDK or later, watchOS 3.0 SDK or later

### Runtime

iOS 10.0 or later, watchOS 3.0 or later

Copyright (C) 2014 Apple Inc. All rights reserved.
