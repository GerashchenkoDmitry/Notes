//
//  ContentView.swift
//  NotesCFT
//
//  Created by Дмитрий Геращенко on 30.09.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
  @Environment(\.managedObjectContext) private var moc
  
  @FetchRequest(
    entity: Note.entity(),
    sortDescriptors: [NSSortDescriptor(keyPath: \Note.date, ascending: true)],
    animation: .default
  )
  
  private var notes: FetchedResults<Note>
 
  @State private var showingAddScreen = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(notes, id: \.self) { note in
          NavigationLink(destination: NoteDetailView(note: note)) {
            VStack(alignment: .leading) {
              
              Text("\(note.title ?? "Unknown title")")
                .fontWeight(.bold)
                .lineLimit(1)
              
              HStack {
                Text("\(note.date ?? Date(), formatter: noteDateFormatter)")
                
                Text(note.noteText ?? "Unknown body text")
                  .lineLimit(1)
              }
            }
          }
          .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              if note.title == "" && note.noteText == "" {
                moc.delete(note)
              }
              try? moc.save()
            }
          }
        }
        .onDelete(perform: deleteItems)
      }
      .listStyle(InsetGroupedListStyle())
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
            EditButton()
        }
        
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: {
            self.showingAddScreen.toggle()
          }) {
            Image(systemName: "plus")
          }
        }
      }
      .navigationTitle("Notes")
      .fullScreenCover(isPresented: $showingAddScreen, content: {
        NewNoteView().environment(\.managedObjectContext, self.moc)
      })
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { notes[$0] }.forEach(moc.delete)
      do {
        try moc.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}

private let noteDateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  return formatter
}()

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
