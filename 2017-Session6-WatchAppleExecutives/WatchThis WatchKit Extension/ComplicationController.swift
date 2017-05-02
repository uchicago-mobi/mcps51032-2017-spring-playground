//
//  ComplicationController.swift
//  WatchThis WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/1/16.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
  
  /// Our timeline of events
  let timeLineText = ["Tim at Keynote","Jonny at Lunch","Angela at Snack","Craig at Dinner"]
  
  //
  // MARK: - Timeline Configuration (CLKComplicationDataSource)
  //
  
  func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
    handler([.forward, .backward])
  }
  
  func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
    let currentDate = Date()
    handler(currentDate)
  }
  
  func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
    // Four hours in the future
    let currentDate = Date()
    let endDate = currentDate.addingTimeInterval(TimeInterval(4 * 60 * 60))
    handler(endDate)
  }
  
  func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
    handler(.showOnLockScreen)
  }
  
  
  //
  // MARK: - Timeline Population (CLKComplicationDataSource)
  //
  
  func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: (@escaping (CLKComplicationTimelineEntry?) -> Void)) {
    // Call the handler with the current timeline entry
    if complication.family == .modularLarge {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "hh:mm"
      
      let timeString = dateFormatter.string(from: Date())
      let entry = createTimeLineEntry(timeString, bodyText: timeLineText[0], date: Date())
      
      handler(entry)
    } else {
      handler(nil)
    }
  }
  
  func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
    // Call the handler with the timeline entries prior to the given date
    handler(nil)
  }
  
  func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: (@escaping ([CLKComplicationTimelineEntry]?) -> Void)) {
    // Call the handler with the timeline entries after to the given date
    var timeLineEntryArray = [CLKComplicationTimelineEntry]()

    // For demonstration purposes, have the next one show every hour
    var nextDate = Date(timeIntervalSinceNow: 1 * 60 * 60)
    
    for index in 1...3 {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "hh:mm"
      let timeString = dateFormatter.string(from: nextDate)
      let entry = createTimeLineEntry(timeString, bodyText: timeLineText[index], date: nextDate)
      timeLineEntryArray.append(entry)
      nextDate = nextDate.addingTimeInterval(1 * 60 * 60)
    }
    handler(timeLineEntryArray)
  }
  
  
  //
  // MARK: - Update Scheduling (CLKComplicationDataSource)
  //
  
  func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
    // Call the handler with the date when you would next like to be given the opportunity to update your complication content
    handler(nil);
  }
  
  
  //
  // MARK: - Placeholder Templates (CLKComplicationDataSource)
  //
  
  func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
    // This method will be called once per supported complication, and the results will be cached
    let template = CLKComplicationTemplateModularLargeStandardBody()
    let apple = UIImage(named: "Complication/Modular")
    template.headerImageProvider = CLKImageProvider(onePieceImage: apple!)
    
    template.headerTextProvider = CLKSimpleTextProvider(text: "Faces")
    template.body1TextProvider = CLKSimpleTextProvider(text: "Apple Executives")
    
    handler(template)
  }
  
  
  // 
  // MARK: Data formating
  //
  func createTimeLineEntry(_ headerText: String, bodyText: String, date: Date) -> CLKComplicationTimelineEntry {
    
    let template = CLKComplicationTemplateModularLargeStandardBody()
    let apple = UIImage(named: "Complication/Modular")
    template.headerImageProvider = CLKImageProvider(onePieceImage: apple!)
    template.headerTextProvider = CLKSimpleTextProvider(text: headerText)
    template.body1TextProvider = CLKSimpleTextProvider(text: bodyText)
    
    let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
    
    return(entry)
  }
}


