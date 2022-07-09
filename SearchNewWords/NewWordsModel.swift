//
//  NewWordsModel.swift
//  SearchNewWords
//
//  Created by 신동희 on 2022/07/09.
//

import Foundation

struct NewWords {
    
    private var newWordsList: [String: String] = [:]
    
    init() {
        newWordsList = [:]
    }
    
    
    func searchNewWords(_ keyWord: String) -> (Bool, String) {
        
        if let searchResult = newWordsList.filter({$0.key == keyWord}).values.first {
            return (true, searchResult)
        }else {
            return (false, "")
        }
    }
}
