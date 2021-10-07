//
//  NoteView.swift
//  NotesCFT
//
//  Created by Дмитрий Геращенко on 30.09.2021.
//

import SwiftUI
import CoreData

struct NewNoteView: View {
  
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  
  @State private var showingDeleteAlert = false
  @State private var noteTitle = ""
  @State private var noteText = ""
  @State private var date = Date()
        
  var body: some View {
    GeometryReader { geometry in
      NavigationView {
        VStack(alignment: .leading, spacing: 0) {
       
          MultilineTextField("", text: $noteText, onCommit: {
            noteText += "\r\n"
//            if noteTitle.isEmpty {
//              noteTitle = noteText.stringBefore("\r\n")
//            }
          })
          
          Spacer()
        }
        .padding()
        .navigationBarItems(
          leading:
            Button(action: {
              withAnimation {
                let newNote = Note(context: self.moc)
                
                  newNote.title = self.noteText.stringBefore("\r\n")
                  newNote.noteText = self.noteText.stringAfter("\r\n")
                  newNote.date = self.date
                
                try? self.moc.save()
                presentationMode.wrappedValue.dismiss()
              }
            }, label: { HStack(spacing: 0) {
              Image(systemName: "chevron.left")
              Text("Notes")
            }}),
          trailing:
            Button(action: { hidekeyboard()},
                   label: { Text("Done")}
            )
        )
        .navigationBarTitle("", displayMode: .inline)
      }
    }
    .ignoresSafeArea(.keyboard, edges: .bottom)
  }
}

struct NewNoteView_Previews: PreviewProvider {
  static var previews: some View {
    NewNoteView()
  }
}
