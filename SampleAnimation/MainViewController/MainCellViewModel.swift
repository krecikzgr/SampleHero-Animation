//
//  MainCellViewModel.swift
//  SampleAnimation
//
//  Created by Adrian Kaleta on 03/12/2020.
//

import Foundation


struct MainCellViewModel {
    let name: String
    let surname: String
    
    var title: String {
        return name + " " + surname
    }
    
    var avatarTitle: String {
        return [name, surname].compactMap{$0.first}
            .map{ String($0).uppercased()}
            .joined(separator: "")
    }
}
