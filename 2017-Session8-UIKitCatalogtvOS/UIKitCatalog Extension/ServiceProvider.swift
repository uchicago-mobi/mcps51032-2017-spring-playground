/*
    Copyright (C) 2017 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A class that conforms to the `TVTopShelfProvider` protocol. The Top Shelf extension uses this class to query for items to show.
*/

import TVServices

class ServiceProvider: NSObject, TVTopShelfProvider {
    // MARK: TVTopShelfProvider
    
    /**
        The style of Top Shelf items to show.
        Modify this property to view different styles.
    */
    let topShelfStyle: TVTopShelfContentStyle = .sectioned
    
    var topShelfItems: [TVContentItem] {
        switch topShelfStyle {
            case .inset:
                return insetTopShelfItems
            
            case .sectioned:
                return sectionedTopShelfItems
        }
    }
    
    // MARK: Convenience
    
    /// An array of `TVContentItem`s to show when `topShelfStyle` returns `.Inset`.
    fileprivate var insetTopShelfItems: [TVContentItem] {
        // Get an array of `DataItem`s to show on the Top Shelf.
        let itemsToDisplay = DataItem.sampleItemsForInsetTopShelfItems
        
        // Map the array of `DataItem`s to an array of `TVContentItem`s.
        let contentItems: [TVContentItem] = itemsToDisplay.map { dataItem in
            return contentItemWithDataItem(dataItem, imageShape: .extraWide)
        }
    
        return contentItems
    }
    
    /**
        An array of `TVContentItem`s to show when `topShelfStyle` returns `.Sectioned`.
    
        Each `TVContentItem` in the returned array represents a section of
        `TVContentItem`s on the Top Shelf. e.g.
    
            - TVContentItem, "Iceland"
                - TVContentItem, "Iceland one"
                - TVContentItem, "Iceland two"
            
            - TVContentItem, "Lola"
                - TVContentItem, "Lola one"
                - TVContentItem, "Lola two"
    */
    fileprivate var sectionedTopShelfItems: [TVContentItem] {
        // Get an array of `DataItem` arrays to show on the Top Shelf.
        let groupedItemsToDisplay = DataItem.sampleItemsForSectionedTopShelfItems
        
        /*
            Map the array of `DataItem` arrays to an array of `TVContentItem`s.
            Each `TVContentItem` will represent a section of `TVContentItem`s on
            the Top Shelf.
        */
        let sectionContentItems: [TVContentItem] = groupedItemsToDisplay.map { dataItems in
            // Determine the title of the `DataItem.Group` that the array of `DataItem`s belong to.
            let sectionTitle = dataItems.first!.group.rawValue
            
            /*
                Create a `TVContentItem` that will represent a section of `TVContentItem`s
                on the Top Shelf.
            */
            guard let sectionIdentifier = TVContentIdentifier(identifier: sectionTitle, container: nil) else { fatalError("Error creating content identifier for section item.") }
            guard let sectionItem = TVContentItem(contentIdentifier: sectionIdentifier) else { fatalError("Error creating section content item.") }

            sectionItem.title = sectionTitle

            /*
                Map the array of `DataItem`s to an array of `TVContentItem`s and
                assign it to the `TVContentItem` that represents the section of
                Top Shelf items.
            */
            sectionItem.topShelfItems = dataItems.map { dataItem in
                return contentItemWithDataItem(dataItem, imageShape: .square)
            }
            
            return sectionItem
        }
        
        return sectionContentItems
    }

    /// Returns a `TVContentItem` for a `DataItem`.
    fileprivate func contentItemWithDataItem(_ dataItem: DataItem, imageShape: TVContentItemImageShape) -> TVContentItem {
        guard let contentIdentifier = TVContentIdentifier(identifier: dataItem.identifier, container: nil) else { fatalError("Error creating content identifier.") }
        guard let contentItem = TVContentItem(contentIdentifier: contentIdentifier) else { fatalError("Error creating content item.") }
        
        contentItem.title = dataItem.title
        contentItem.displayURL = dataItem.displayURL
        contentItem.imageURL = dataItem.imageURL
        contentItem.imageShape = imageShape
        
        return contentItem
    }
}
