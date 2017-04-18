//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true

let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
var dataTask: URLSessionDataTask?
let searchTerm = "flappy"

let url = URL(string: "https://itunes.apple.com/search?entity=software&term=\(searchTerm)")

dataTask = defaultSession.dataTask(with: url!, completionHandler: {
  data, response, error in
  if let error = error {
    print(error.localizedDescription)
  } else if let httpResponse = response as? HTTPURLResponse {
    if httpResponse.statusCode == 200 {
      
      guard let data = data else {
        print("Bad data")
        return
      }
      do {
        if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
          let apps = json["results"] as? [[String: Any]] {
          print(apps)
        }
      } catch {
        print("Error deserializing JSON: \(error)")
      }
    }
  }
})

dataTask?.resume()

