//
//  ViewController.swift
//  moodTracker
//
//  Created by Rinni Swift on 11/8/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cellID = "moodEntryCell"
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    @IBAction func unwindToMain(_ segue: UIStoryboardSegue) {
        guard let identifier = segue.identifier else {
            return
        }
        
        guard let destination = segue.source as? DetailedViewController else {
            return print("storyboard unwind segue not setup properly")
        }
        
        switch identifier {
        case "unwindFromSave":
            let newMood: MoodEntry.Mood = destination.mood
            let newDate: Date = destination.date
            if destination.isEditingEntry {
                guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
                print("from save button and editing an existing mood")
                updateEntry(mood: newMood, date: newDate, at: selectedIndexPath.row)
            } else {
                createEntry(mood: newMood, date: newDate)
                print("from save button and adding a new entry")
            }
        case "unwindFromCancel":
            print("from cancel button")
            
        default:
            break
        }
    }
    
    func createEntry(mood: MoodEntry.Mood, date: Date) {
        let newEntry = MoodEntry(mood: mood, date: date)
        entries.insert(newEntry, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    func updateEntry(mood: MoodEntry.Mood, date: Date, at index: Int) {
        entries[index].mood = mood
        entries[index].date = date
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    func deleteEntry(at index: Int) {
        entries.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

//    @IBAction func addEntry(_ sender: UIBarButtonItem) {
//        let now = Date()
//        let newMood = MoodEntry(mood: .amazing, date: now)
//        entries.insert(newMood, at: 0)
//        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//        print("added entry: \(newMood.mood.stringValue)")
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showNewEntry":
                guard let destination = segue.destination as? DetailedViewController else {
                    return print("storyboard not set up correctly, 'show entry details' segue needs to segue to a 'MoodDetailedViewController'")
                }
                destination.mood = MoodEntry.Mood.none
                destination.date = Date()
                
            case "showEntryDetails":
                guard let selectedCell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: selectedCell) else {
                        return print("failed to locate index path from sender")
                }
                
                guard let destination = segue.destination as? DetailedViewController else {
                    return print("storyboard not set up properely, 'show entry details' segue needs to segue to a 'DetailedViewController'")
                }
                
                let entry = entries[indexPath.row]
                destination.mood = entry.mood
                destination.date = entry.date
                destination.isEditingEntry = true
            default: break
            }
        }
        
    }
    
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MoodEntryTableViewCell
        
        let entry = entries[indexPath.row]
        cell.configure(entry)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEntry = entries[indexPath.row]
        print("Selected mood was \(selectedEntry.mood.stringValue)")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteEntry(at: indexPath.row)
        default:
            break
        }
    }
    
}
