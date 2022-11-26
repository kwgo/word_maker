//
//  WordHelper.swift
//  word_maker WatchKit Extension
//
//  Created by MacBook Air on 2022-11-26.
//

import Foundation

public class WordHelper {    
    private static var wordHelper = WordHelper()
    
    public static func instance() -> WordHelper {
        return wordHelper
    }
    
    var words: [[String]] = [[], [], [], [], [], [],[], [], []]
    
    public func getWords() -> [String] {
        return self.words[self.bookIndex];
    }
    
    private init() {
        print("word help init ========")
        for index in 3-3 ... 9-3 {
            let lines = self.loadWords(index: index)
            self.words[index] = lines
        }
    }
    
    private var bookIndex = -1
    
    public func getBookIndex() -> Int {
        return self.bookIndex
    }
    
    public func setBookIndex(_ bookIndex: Int) {
        self.bookIndex = bookIndex
    }
    
    private var wordIndex = 0
    
    public func getWordIndex() -> Int {
        return self.wordIndex
    }
    
    public func getWordCount() -> Int {
        return self.words[self.bookIndex].count
    }
    
    public func setWordIndex(_ wordIndex: Int) {
        self.wordIndex = wordIndex
    }
    
    public func setWordIndex(next: Bool) {
        self.wordIndex = self.wordIndex + (next ? 1 : 0)
        self.wordIndex = self.wordIndex % self.words[self.bookIndex].count
    }
    
    public func getWord() -> String {
        self.words[self.bookIndex][self.wordIndex]
    }
    
    public func loadWords(index: Int) -> [String] {
        var lines: [String] = []
        do {
            let name: String = "word_" + String(index + 3) + ".txt"
            let path = Bundle.main.path(forResource: name, ofType: nil)
            let file = try String(contentsOfFile: path!)
            lines = file.components(separatedBy: "\n")
        } catch let error {
            Swift.print("Fatal Error: \(error.localizedDescription)")
        }
        return lines
    }
}
