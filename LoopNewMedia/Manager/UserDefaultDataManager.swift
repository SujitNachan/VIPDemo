//
//  UserDefaultDataManager.swift
//  LoopNewMedia
//
//  Created by  on 03/11/22.
//

import Foundation

class UserDefaultDataManager {
    static let shared = UserDefaultDataManager()
    private var bookmarkIds = [Int]()
    private init() {
        bookmarkIds = retriveBookMarks()
    }
    
    func addBookmark(id: Int) {
        if !bookmarkIds.contains(id) {
            bookmarkIds.append(id)
            saveInUserDefaults()
        }
    }
    
    func removeBookmark(id: Int) {
        if bookmarkIds.contains(id),
           let index = bookmarkIds.firstIndex(of: id)
        {
            bookmarkIds.remove(at: index)
            saveInUserDefaults()
        }
    }
    
    private func saveInUserDefaults() {
        UserDefaults.standard.set(bookmarkIds, forKey: "Bookmarks")
        UserDefaults.standard.synchronize()
    }
    
    func retriveBookMarks() -> [Int] {
        return UserDefaults.standard.value(forKey: "Bookmarks") as? [Int] ?? []
    }
}
