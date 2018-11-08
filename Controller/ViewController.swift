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
        
        let goodEntry = MoodEntry(mood: .good, date: Date())
        let neutralEntry = MoodEntry(mood: .neutral, date: Date())
        let badEntry = MoodEntry(mood: .bad, date: Date())
        
        entries = [goodEntry, neutralEntry, badEntry]
        tableView.reloadData()
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



