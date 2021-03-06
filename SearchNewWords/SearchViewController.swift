//
//  ViewController.swift
//  SearchNewWords
//
//  Created by 신동희 on 2022/07/09.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Propertys
    var newWordsModel = NewWordsModel()
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // 검색창 하단의 연관(?) 신조어 버튼 4개
    @IBOutlet var newWordsExampleList: [UIButton]!
    
    @IBOutlet weak var searchResultLabel: UILabel!
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        
        updateRandomButtonTitle()
        
        newWordsExampleList.forEach({settingExampleButtonUI($0)})
    }


    
    // MARK: - Methods
    
    // 검색창 하단 버튼 4개 UI 설정
    func settingExampleButtonUI(_ button: UIButton) {
        addRadius(button)
        addBorder(button)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    // Radius 추가
    func addRadius(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.height / 5
    }
    
    // 테두리 추가
    func addBorder(_ view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
    }
    
    // 검색 실패했을 때 보여줄 Alert
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: "검색 실패", message: "\(message)라는 신조어는 등록되지 않았습니다.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            // 피드백 반영: self를 옵셔널 바인딩하여 처리
            // 옵셔널 바인딩을 추가함으로써 얻는 이점 (추측..)
            // 옵셔널 바인딩에 실패하면 바로 return하므로 불필요한 코드 실행을 방지한다. => 성능개선
            guard let searchVC = self else { return }
            searchVC.searchTextField.text = nil
            searchVC.searchResultLabel.text = nil
            
//            self?.searchTextField.text = nil
//            self?.searchResultLabel.text = nil
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    // 백그라운드 탭 (키보드 내리기)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // 검색 버튼 탭
    @IBAction func searchButtonDidTapped(_ sender: UIButton) {
        textFieldShouldReturn(searchTextField)
    }
    
    // TextField 하단 신조어 버튼 탭
    @IBAction func newWordsButtonTapped(_ sender: UIButton) {
        searchNewWords(sender.currentTitle ?? "")
        updateRandomButtonTitle()
    }
    
    // 신조어 검색
    func searchNewWords(_ keyWord: String) {
        let searchResult = newWordsModel.searchNewWords(keyWord)
        
        if searchResult.0 {
            // 검색 결과가 ture인 경우
            searchResultLabel.text = searchResult.1
        }else {
            // 검색 결과가 false인 경우
            presentAlert(message: keyWord)
        }
    }
    
    // TextField 하단 신조어 예시 버튼들 업데이트
    func updateRandomButtonTitle() {
        let randomNewWords = newWordsModel.getRandomNewWords()
        for (newWord, button) in zip(randomNewWords, newWordsExampleList) {
            button.setTitle(newWord.rawValue, for: .normal)
        }
    }
}



extension SearchViewController: UITextFieldDelegate {
    
    // Enter을 사용한 검색
    @discardableResult
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        searchNewWords(textField.text ?? "")
        updateRandomButtonTitle()
        
        return true
    }
}
