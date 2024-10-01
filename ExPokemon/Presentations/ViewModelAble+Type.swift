//
//  ViewModelAble+Type.swift
//  ExPokemon
//
//  Created by 강동영 on 10/1/24.
//

import Foundation

protocol ViewModelAble {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
