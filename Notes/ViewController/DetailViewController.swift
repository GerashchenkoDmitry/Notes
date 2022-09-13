//
//  DetailViewController.swift
//  Notes
//
//  Created by Дмитрий Геращенко on 04.09.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    private var noteText = UITextView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureDoneDutton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNoteText()
    }
    
    func configureDetailView(_ note: Note) {
        self.title = note.name
        noteText.text = "\(note.name)\n\(note.text)"
    }
    
    private func configureDoneDutton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    }
    
    private func configureNoteText() {
        noteText.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(noteText)
    }
    
    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        noteText.frame = CGRect(x: view.safeAreaInsets.left,
                                y: view.safeAreaInsets.top,
                                width: view.frame.width,
                                height: view.frame.height)
    }
}
