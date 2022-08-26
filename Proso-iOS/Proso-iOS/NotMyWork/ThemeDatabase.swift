//
//  Database.swift
//  Proso-iOS
//
//  Created by 유재호 on 2022/08/06.
//
import Foundation

final class ThemeDatabase {
    private let FAV_KEY = "fav_key"
    
    func save(items: Set<Int>) {
        let array = Array(items)
        UserDefaults.standard.set(array, forKey: FAV_KEY)
    }
    
    func load() -> Set<Int> {
        let array = UserDefaults.standard.array(forKey: FAV_KEY) as? [Int] ?? [Int]()
        return Set(array)
        
    }
}
