//
//  ViewController.swift
//  SearchNewWords
//
//  Created by 신동희 on 2022/07/09.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Propertys
    var newWordsModel = NewWords()
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet var newWordsExampleList: [UIButton]!
    
    @IBOutlet weak var searchResultLabel: UILabel!
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        
        updateRandomButtonTitle("")
        
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
    
    
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: "검색 실패", message: "\(message)라는 신조어는 등록되지 않았습니다.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.searchTextField.text = nil
            self?.searchResultLabel.text = nil
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func searchButtonDidTapped(_ sender: UIButton) {
        textFieldShouldReturn(searchTextField)
    }
    
    
    @IBAction func newWordsButtonTapped(_ sender: UIButton) {
        searchNewWords(sender.currentTitle ?? "")
        updateRandomButtonTitle(sender.currentTitle ?? "")
    }
    
    func searchNewWords(_ keyWord: String) {
        let searchResult = newWordsModel.searchNewWords(keyWord)
        
        if searchResult.0 {
            searchResultLabel.text = searchResult.1
        }else {
            presentAlert(message: keyWord)
        }
    }
    
    func updateRandomButtonTitle(_ currentKeyWord: String) {
        let randomNewWords = newWordsModel.getRandomNewWords(currentKeyWord)
        for (word, button) in zip(randomNewWords, newWordsExampleList) {
            button.setTitle(word, for: .normal)
        }
    }
}



extension SearchViewController: UITextFieldDelegate {
    
    @discardableResult
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        searchNewWords(textField.text ?? "")
        updateRandomButtonTitle(textField.text ?? "")
        
        return true
    }
}
