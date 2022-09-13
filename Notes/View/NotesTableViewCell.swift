//
//  TableViewCell.swift
//  Notes
//
//  Created by Дмитрий Геращенко on 02.09.2022.
//

import UIKit

final class NotesTableViewCell: UITableViewCell {
    
    static var reuseID: String {
        String(describing: Self.self)
    }
    
    private var noteName = UILabel()
    private var noteText = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureNoteName()
        configureNoteText()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureCell(with note: Note) {
        self.noteName.text = note.name
        self.noteText.text = note.text
    }
    
    private func configureNoteName() {
        noteName.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        noteName.sizeToFit()
        
        contentView.addSubview(noteName)
    }
    
    private func configureNoteText() {
        noteText.numberOfLines = 1
        noteText.sizeToFit()
        
        contentView.addSubview(noteText)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        noteName.frame = CGRect(x: self.safeAreaInsets.left + 8,
                                y: self.safeAreaInsets.top + 8,
                                width: self.frame.width,
                                height: 22)

        noteText.frame = CGRect(x: self.safeAreaInsets.left + 8,
                                y: noteName.frame.maxY + 20,
                                width: self.frame.width,
                                height: 22)
    }
}
