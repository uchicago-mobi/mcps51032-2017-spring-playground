//
//  BackgroundDownloadViewController.swift
//  WatchYourBack
//
//  Created by T. Andrew Binkowski on 5/7/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit

class BackgroundDownloadViewController: UIViewController {
  
  /// Start a download that will persist through moving to background
  @IBAction func tapDownload(_ sender: Any) {
    print("Tap download")
    let config = URLSessionConfiguration.background(withIdentifier: "mobi.uchicago.download")
    config.sessionSendsLaunchEvents = true
    let session = URLSession(configuration: config,
                             delegate: self,
                             delegateQueue: OperationQueue())
    let url = URL(string: "https://static.pexels.com/photos/104827/cat-pet-animal-domestic-104827.jpeg")
    let downloadTask = session.downloadTask(with: url!)
    downloadTask.resume()
  }
  
  /// ImageView to show our downloaded image
  @IBOutlet weak var imageView: UIImageView!
}


///
///
///
extension BackgroundDownloadViewController: URLSessionDownloadDelegate {
  
  
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                  didWriteData bytesWritten: Int64,
                  totalBytesWritten: Int64,
                  totalBytesExpectedToWrite: Int64) {
    if totalBytesExpectedToWrite > 0 {
      let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
      print("Progress \(downloadTask) \(progress)")
    }
  }
  
  ///
  func urlSession(_ session: URLSession,
                  task: URLSessionTask,
                  didCompleteWithError error: Error?) {
    print("Task completed: \(task), error: \(String(describing: error))")
  }
  
  ///
  func urlSession(_ session: URLSession,
                  downloadTask: URLSessionDownloadTask,
                  didFinishDownloadingTo location: URL){
    
    print("Download finished: \(location)")
    
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                   FileManager.SearchPathDomainMask.userDomainMask,
                                                   true)[0]
    let fileManager = FileManager()
    let destinationURLForFile = URL(fileURLWithPath: path.appendingFormat("/downloaded.jpg"))
    try? fileManager.removeItem(at: destinationURLForFile)
    
    do {
      try fileManager.moveItem(at: location, to: destinationURLForFile)
      let image = UIImage(contentsOfFile: path.appendingFormat("/downloaded.jpg"))
      DispatchQueue.main.async {
        self.imageView.image = image
      }
    } catch {
      print("An error occurred while moving file to destination url")
    }
  }
}

