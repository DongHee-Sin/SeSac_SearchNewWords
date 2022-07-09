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
        newWordsList = [
            "삼귀자": "연애를 시작하기 전 썸 단계!",
            "꾸안꾸": "꾸민듯 안꾸민듯",
            "만반잘부": "만나서 반가워 잘 부탁해",
            "댕댕이": "멍멍이",
            "남아공": "남아서 공부나 해",
            "답정너": "답은 정해져 있고 너는 대답만 해",
            "따아": "따뜻한 아메리카노",
            "아아": "아이스 아메리카노",
            "아샷추": "아이스티에 샷 추가",
            "띵작": "명작"
        ]
    }
    
    
    func searchNewWords(_ keyWord: String) -> (Bool, String) {
        
        if let searchResult = newWordsList.filter({$0.key == keyWord}).values.first {
            return (true, searchResult)
        }else {
            return (false, "")
        }
    }
    
    
    func getRandomNewWords(_ currentKeyWord: String) -> Set<String> {
        let newWordsArray = newWordsList.keys
        var randomSet: Set<String> = [currentKeyWord]
        
        while randomSet.count <= 4 {
            randomSet.insert(newWordsArray.randomElement()!)
        }
        
        randomSet.remove(currentKeyWord)
        
        return randomSet
    }
}
