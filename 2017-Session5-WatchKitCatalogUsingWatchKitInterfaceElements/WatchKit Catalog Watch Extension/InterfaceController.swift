/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This is the initial interface controller for the WatchKit app. It loads the initial table of the app with data and responds to Handoff launching the WatchKit app.
 */

import WatchKit
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    @IBOutlet var interfaceTable: WKInterfaceTable!
    var elementsList: NSArray!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        WCSession.default().delegate = self
        WCSession.default().activate()

        // Initialize variables here.
        // Configure interface objects here.

        
        // Retrieve the data. This could be accessed from the iOS app via a shared container.
        elementsList = NSArray(contentsOfFile: Bundle.main.path(forResource: "AppData", ofType: "plist")!)
        
        loadTableRows()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    override func handleUserActivity(_ userInfo: [AnyHashable : Any]?) {
        guard let userInfo = userInfo else { return }
        
        // Use data from the userInfo dictionary passed in to push to the appropriate controller with detailed info.
        pushController(withName: userInfo["controllerName"] as! String, context: userInfo["detailInfo"] as! String)
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let rowData = elementsList[rowIndex] as! NSDictionary
    
        pushController(withName: rowData["controllerIdentifier"] as! String, context: nil)
    }
    
    func loadTableRows() {
        interfaceTable.setNumberOfRows(self.elementsList.count, withRowType: "default")

        // Create all of the table rows.
        for idx in 0 ... elementsList.count-1 {
            let elementRow = interfaceTable.rowController(at: idx) as! ElementRowController
            let rowData = elementsList[idx] as! NSDictionary
            elementRow.elementLabel.setText(rowData["label"] as? String)
        }
    }
}
