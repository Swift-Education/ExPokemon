//
//  UIImageView+.swift
//  ExPokemon
//
//  Created by 강동영 on 8/10/24.
//

import UIKit

extension UIImageView {
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
