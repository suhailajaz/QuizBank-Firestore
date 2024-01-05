//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by suhail on 07/09/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

class Question: Codable{
    
    
    var text: String = ""
    var answer: String = ""
    
     init(q: String, a: String) {
        self.text = q
        self.answer = a
    }
}
