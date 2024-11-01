//
//  ContentView.swift
//  DiscGolfBagManager
//
//  Created by Finley Vickers on 2024-10-13.
//
import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: BagViewModel
    @State private var showingAddDisc = false

    init(viewContext: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: BagViewModel(viewContext: viewContext))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.discs) { disc in
                    DiscRow(disc: disc)
                }
                .onDelete(perform: viewModel.removeDisc)
            }
            .navigationTitle("My Disc Bag")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddDisc = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Suggest") {
                        if let suggestedDisc = viewModel.suggestDisc() {
                            viewModel.addDisc(
                                name: suggestedDisc.name,
                                type: suggestedDisc.type,
                                speed: suggestedDisc.speed,
                                glide: suggestedDisc.glide,
                                turn: suggestedDisc.turn,
                                fade: suggestedDisc.fade
                            )
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddDisc) {
                AddDiscView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewContext: PersistenceController.preview.container.viewContext)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
