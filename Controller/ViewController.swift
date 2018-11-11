//
//  ViewController.swift
//  moodTracker
//
//  Created by Rinni Swift on 11/8/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var entries = [MoodEntry]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let goodEntry = MoodEntry(mood: .good, date: Date())
        let neutralEntry = MoodEntry(mood: .neutral, date: Date())
        let badEntry = MoodEntry(mood: .bad, date: Date())
        
        entries = [goodEntry, neutralEntry, badEntry]
        tableView.reloadData()
    }

    @IBAction func addEntry(_ sender: UIBarButtonItem) {
        let now = Date()
        let newMood = MoodEntry(mood: .amazing, date: now)
        entries.insert(newMood, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        print("added entry: \(newMood.mood.stringValue)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showEntryDetails":
                guard
                    let selectedCell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: selectedCell) else {
                        return print("failed to locate index path from sender")
                }
                
                guard let destination = segue.destination as? MoodDetailedViewController else {
                    return print("story board not set up correctly")
                }
                
                let entry = entries[indexPath.row]
                destination.mood = entry.mood
                destination.date = entry.date
            default: break
            }
        }
        
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEntry = entries[indexPath.row]
        print("selected mood was \(selectedEntry.mood.stringValue)")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moodEntryCell", for: indexPath) as! MoodEntryTableViewCell
        
        let entry = entries[indexPath.row]
        cell.labelMoodTitle.text = entry.mood.stringValue
        cell.labelMoodDate.text = String(describing: entry.date)
        cell.imageViewMoodColor.backgroundColor = entry.mood.colorValue
        
        return cell
    }
    
    
    
}



