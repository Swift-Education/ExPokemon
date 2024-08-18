//
//  UIViewController+Reactive.swift
//  ExPokemon
//
//  Created by 강동영 on 8/18/24.
//

import UIKit.UIViewController
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewWillAppear: Observable<Void> {
        return methodInvoked(#selector(Base.viewWillAppear(_:)))
            .map { _ in }
    }
}
