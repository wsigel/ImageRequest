//
//  ViewController.swift
//  ImageRequest
//
//  Created by Wolfgang Sigel on 28.03.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import UIKit

enum KittenImageLocation: String {
    case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    case error = "not a url"
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let imageLocation = KittenImageLocation.http.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleLoadImageButtonPressed(_ sender: Any) {
        guard let imageURL = URL(string: imageLocation) else {
            print("Cannot create URL")
            return
        }
        
         // first alternative: using a DataTask
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            guard let data = data else {
                print("no data or there was an error")
                return
            }
            let downloadedIamge = UIImage(data: data)
            DispatchQueue.main.async {
                self.imageView.image = downloadedIamge
            }
        }
         
        // second alternative: using a DownloadTask
//        let task = URLSession.shared.downloadTask(with: imageURL) { (location, response, error) in
//            guard let location = location else {
//                print("location is nil")
//                return
//            }
//            print(location)
//            let imageData = try! Data(contentsOf: location)
//            let image = UIImage(data: imageData)
//            DispatchQueue.main.async {
//                self.imageView.image = image
//            }
//        }
        task.resume()
    }
    
    


}

