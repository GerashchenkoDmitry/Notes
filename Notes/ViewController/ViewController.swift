//
//  ViewController.swift
//  Notes
//
//  Created by Дмитрий Геращенко on 02.09.2022.
//

import UIKit

final class ViewController: UIViewController {
    private var notes = [
        Note(name: "Note 1",
             text: "Note 1 Text"),
        Note(name: "Note 2",
             text: "Note 2 Text")
    ]
    private var tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.title = "Notes"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.reuseID)
        
        view.addSubview(tableView)
    }
    
    @objc private func addButtonTapped() {
        let newNoteView = NewNoteViewController()
        navigationController?.pushViewController(newNoteView, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: view.safeAreaInsets.left,
                                 y: view.safeAreaInsets.top,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.reuseID, for: indexPath) as? NotesTableViewCell else { return UITableViewCell() }
        cell.configureCell(with: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        let detailView = DetailViewController()
        detailView.configureDetailView(note)
        
        navigationController?.pushViewController(detailView, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
