/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main view that contains the majority of the app's content.
*/

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var cards: [Card]
    @State private var editing = false
    @State private var navigationPath: [Card] = []

    var body: some View {
        NavigationStack(path: $navigationPath) {
            CardGallery(cards: cards, editing: $editing) { card in
                withAnimation { navigationPath.append(card) }
            } addCard: {
                let newCard = Card(front: "Sample Front", back: "Sample Back")
                // save card
                modelContext.insert(newCard)
                withAnimation {
                    navigationPath.append(newCard)
                    editing = true
                }
            }
            .padding()
            .toolbar { EditorToolbar(isEnabled: false, editing: $editing) }
        }
    }
}

#Preview {
    ContentView()
        .frame(minWidth: 500, minHeight: 500)
        .modelContainer(previewContainer)
}
