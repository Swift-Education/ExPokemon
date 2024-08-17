//
//  UIImageView+.swift
//  ExPokemon
//
//  Created by 강동영 on 8/10/24.
//

import UIKit

extension UIImageView {
    func fetchImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    func cancelDownloadTask() {
        currentTask?.cancel()
    }
}

extension UIImageView {
    private static var taskKey = 0
    
    private var currentTask: URLSessionDataTask? {
        get {
            return objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionDataTask
        }
        set {
            objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
