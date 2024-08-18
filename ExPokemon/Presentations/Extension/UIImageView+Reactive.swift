//
//  UIImageView+Reactive.swift
//  ExPokemon
//
//  Created by 강동영 on 8/18/24.
//

import UIKit.UIImageView
import RxSwift

extension Reactive where Base: UIImageView {
    func loadImage(url: URL) -> Observable<UIImage?> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    observer.onNext(nil)
                    observer.onCompleted()
                    return
                }
                observer.onNext(image)
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
