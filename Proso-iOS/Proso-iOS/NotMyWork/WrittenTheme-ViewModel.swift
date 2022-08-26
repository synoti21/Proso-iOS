//
//  WrittenTheme-ViewModel.swift
//  Proso-iOS
//
//  Created by 유재호 on 2022/08/06.
//

import Foundation
import SwiftUI
/*
extension MyPageTheme {
    final class ViewModel: ObservableObject {
        @Published var items = [Item]()
        @Published var showingFavs = false
        @Published var savedItems: Set<Int> = [1, 7]
        
        // Filter saved items
        var filteredItems: [Item]  {
            if showingFavs {
                return items.filter { savedItems.contains($0.id) }
            }
            return items
        }
        
        private var db = ThemeDatabase()
        
        init() {
            self.savedItems = db.load()
            self.items = Item.sampleItems
        }
        
        func sortFavs() {
            withAnimation() {
                showingFavs.toggle()
            }
        }
        
        func contains(_ item: Item) -> Bool {
                savedItems.contains(item.id)
            }
        
        // Toggle saved items
        func toggleFav(item: Item) {
            if contains(item) {
                savedItems.remove(item.id)
            } else {
                savedItems.insert(item.id)
            }
            db.save(items: savedItems)
        }
    }
}
*/
