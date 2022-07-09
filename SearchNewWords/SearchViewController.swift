//
//  ViewController.swift
//  SearchNewWords
//
//  Created by 신동희 on 2022/07/09.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Propertys
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet var newWordsExampleList: [UIButton]!
    
    
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newWordsExampleList.forEach({
            settingExampleButtonUI($0)
        })
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
}

