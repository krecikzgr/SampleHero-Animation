//
//  RandomViewModelsGenerator.swift
//  SampleAnimation
//
//  Created by Adrian Kaleta on 04/12/2020.
//

import Foundation

class RandomViewModelsGenerator {
   static let names: [String] = ["Ashlyn",
                           "Eddie",
                           "Kealan",
                           "Hanna",
                           "Christy",
                           "Rebecca",
                           "Liyah",
                           "Baran",
                           "Crystal",
                           "Huzaifah"]
    
    static let surnames:[ String] = ["Thorpe",
                            "Delarosa",
                            "Mcclure",
                            "Potts",
                            "Neville",
                            "Decker",
                            "Mcghee",
                            "Lawson",
                            "Mccaffrey",
                            "Garrison"]

    static func getViewModels(amount: Int) ->[MainCellViewModel] {
        return (0..<amount).map { (number) -> MainCellViewModel in
            let nameIndex = Int.random(in: 0..<RandomViewModelsGenerator.names.count)
            let name = RandomViewModelsGenerator.names[nameIndex]
            let surnameIndex = Int.random(in: 0..<RandomViewModelsGenerator.surnames.count)
            let surname = RandomViewModelsGenerator.surnames[surnameIndex]
            
            return MainCellViewModel(name: name, surname: surname)
        }
    }
}
