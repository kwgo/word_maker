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
        for index in 3-3 ... 9-3 {
            let lines = self.loadWords(index: index)
            self.words[index] = lines
        }
        self.numbers = self.loadNumbers()
    }
    
    private var bookIndex = -1
    
    public func getBookIndex() -> Int {
        return self.bookIndex
    }
    
    public func setBookIndex(_ bookIndex: Int) {
        self.bookIndex = bookIndex
        self.wordIndex = self.numbers[bookIndex]
    }
    
    private var wordIndex = 0
    
    public func getWordIndex() -> Int {
        return self.wordIndex
    }
    
    public func getWordCount() -> Int {
        return self.words[self.bookIndex].count
    }
    
    public func setWordIndex(next: Bool) {
        if(next) {
            self.wordIndex = self.wordIndex + 1
            if(self.wordIndex >= self.words[self.bookIndex].count) {
                self.wordIndex = self.words[self.bookIndex].count - 1
            }
            self.numbers[self.bookIndex] = self.wordIndex
            self.saveNumbers(numbers: self.numbers)
        }
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
    
    var numbers: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    public func loadNumbers() -> [Int] {
        var numbers: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        do {
            let name: String = "word_number.txt"
            let paths = FileManager.default.urls (for: .documentDirectory, in: .userDomainMask)
            let path = paths[0].appendingPathComponent(name)
            let file = try String(contentsOf: path)
            let lines = file.components(separatedBy: "\n")
            var index = 0
            for line in lines {
                numbers[index] = Int(line) ?? 0
                index = index + 1
            }
        } catch let error {
            Swift.print("Fatal Error: \(error.localizedDescription)")
        }
        return numbers
    }
    
    public func saveNumbers(numbers: [Int]) {
        do {
            let name: String = "word_number.txt"
            let paths = FileManager.default.urls (for: .documentDirectory, in: .userDomainMask)
            let path = paths[0].appendingPathComponent(name)
            var strings = [String]()
            for number in numbers {
                strings.append(String(number))
            }
            let text = strings.joined(separator: "\n")
            try text.write(to: path, atomically: false, encoding: .utf8)
        } catch let error {
            Swift.print("Fatal Error: \(error.localizedDescription)")
        }
    }
}
