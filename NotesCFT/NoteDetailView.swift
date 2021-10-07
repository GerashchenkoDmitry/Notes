//
//  NoteDetailView.swift
//  NotesCFT
//
//  Created by Дмитрий Геращенко on 30.09.2021.
//

import SwiftUI
import CoreData

struct NoteDetailView: View {
  
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  
  var note: Note
  
  @State private var noteText: String = ""
  @State private var date = Date()
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 0) {
        
      TextEditor(text: $noteText)
        .onAppear {
          noteText = (note.title ?? "Unable to fetch note title") + "\n" + (note.noteText ?? "Unable to fetch note text")
        }
        .onDisappear {
          note.title = self.noteText.stringBefore("\n")
          note.noteText = self.noteText.stringAfter("\n")
          note.date = self.date
          
          try? self.moc.save()
        }
      
        Spacer()
      }
      .navigationBarTitle("", displayMode: .inline)
      .padding()
  }
}



struct NoteDetailView_Previews: PreviewProvider {
  
  static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  
  static var previews: some View {
    
    let note = Note(context: moc)
    
    note.title = "Note Title"
    note.noteText = "Some User Note"
    note.id = UUID()
    note.date = Date()
    
    return NoteDetailView(note: note)
  }
}
