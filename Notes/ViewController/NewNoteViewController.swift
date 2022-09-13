//
//  NewNoteViewController.swift
//  Notes
//
//  Created by Дмитрий Геращенко on 05.09.2022.
//

import UIKit

final class NewNoteViewController: UIViewController {
    private let noteName = UITextField()
    private let noteText = UITextView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        // Done Button hide the keyboard and set viewEditing to end
        configureDoneDutton()
        
        self.title = "New Note"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNoteName()
        configureNoteText()
    }
    
    private func configureBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Notes", style: .plain, target: self, action: #selector(backButtonTapped))
    }
    
    private func configureDoneDutton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    }
    
    private func configureNoteName() {
        noteName.borderStyle = .roundedRect
        noteName.placeholder = "Title"
        
        view.addSubview(noteName)
    }
    
    private func configureNoteText() {
        noteText.font = UIFont.systemFont(ofSize: 17)
        
        view.addSubview(noteText)
    }
    
    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }
    
    @objc private func backButtonTapped() {
        let newNote = Note(name: noteName.text ?? "", text: noteText.text)
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noteName.frame = CGRect(x: view.safeAreaInsets.left + 10,
                                y: view.safeAreaInsets.top + 10,
                                width: view.frame.width - 20,
                                height: 32)
        
        noteText.frame = CGRect(x: view.safeAreaInsets.left + 10,
                                y: noteName.frame.maxY + 8,
                                width: view.frame.width - 20,
                                height: view.frame.height - noteName.frame.height - 10 - 8)
    }
}
