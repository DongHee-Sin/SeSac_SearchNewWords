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
    func settingExampleButtonUI(_ button: UIButton) {
        addRadius(button)
        addBorder(button)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func addRadius(_ view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.height / 5
    }
    
    func addBorder(_ view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
    }
    
    // 검색 실패했을 때 보여줄 Alert
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: "검색 실패", message: "\(message)라는 신조어는 등록되지 않았습니다.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.searchTextField.text = nil
            self?.searchResultLabel.text = nil
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
            searchResultLabel.text = searchResult.1
        }else {
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
