//
//  Face.swift
//  WatchInterface
//
//  Created by T. Andrew Binkowski on 5/18/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import Foundation

///
/// Face class to hold information about people
///
open class Face {
  open let name: String
  open let title: String
  open let imageName: String
  
  init(name: String, title: String) {
    self.name = name
    self.title = title
    self.imageName = name
  }
}


///
/// Faces class to hold a list of all the people
///
open class Faces {
  open var list = [Face]()
  
  public init() {
    
    var face: Face
    
    face = Face(name: "Tim Cook", title: "CEO")
    list.append(face)
    face = Face(name: "Angela Ahrendts", title: "Senior VP")
    list.append(face)
    face = Face(name: "Eddy Cue", title: "Senior VP")
    list.append(face)
    face = Face(name: "Craig Federighi", title: "Senior VP")
    list.append(face)
    face = Face(name: "Jonathan Ive", title: "Senior VP")
    list.append(face)
  }
}
