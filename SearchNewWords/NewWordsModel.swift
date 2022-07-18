//
//  NewWordsModel.swift
//  SearchNewWords
//
//  Created by 신동희 on 2022/07/09.
//

import Foundation


enum NewWord: String, CustomStringConvertible, CaseIterable {
    case 삼귀자
    case 꾸안꾸
    case 만반잘부
    case 댕댕이
    case 남아공
    case 답정너
    case 따아
    case 아아
    case 아샷추
    case 띵작
    
    var description: String {
        switch self {
        case .삼귀자: return "연애를 시작하기 전 썸 단계"
        case .꾸안꾸: return "꾸민듯 안꾸민듯"
        case .만반잘부: return "만나서 반가워 잘 부탁해"
        case .댕댕이: return "멍멍이"
        case .남아공: return "남아서 공부나 해"
        case .따아: return "따뜻한 아메리카노"
        case .아아: return "아이스 아메리카노"
        case .아샷추: return "아이스티 샷추가"
        case .답정너: return "답은 정해져 있고 너는 대답만 해"
        case .띵작: return "명작"
        }
    }
}


struct NewWordsModel {
    
    private var newWordsList: [NewWord] = []
    
    // 열거형 case 리스트를 바탕으로 Model 구조체 초기화
    init() {
        NewWord.allCases.forEach({
            newWordsList.append($0)
        })
    }
    
    // 매개변수로 검색어를 입력하면, 결과값을 튜플로 반환 (검색 성공여부: Bool, 검색결과: String)
    func searchNewWords(_ keyWord: String) -> (Bool, String) {
        
        for newWord in newWordsList {
            if newWord.rawValue == keyWord {
                return (true, newWord.description)
            }
        }
        return (false, "")
    }
    
    
    // 검색창 하단 버튼에 추가하기 위한 랜덤 신조어 4개 반환
    func getRandomNewWords() -> Set<NewWord> {
        
        guard newWordsList.count >= 4 else {return []}
        
        var randomSet: Set<NewWord> = []
        
        while randomSet.count <= 3 {
            randomSet.insert(newWordsList.randomElement()!)
        }
        
        return randomSet
    }
}
