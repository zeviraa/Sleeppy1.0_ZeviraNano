//
//  AddScheduleViewController.swift
//  Sleeppy1.0_ZeviraNano
//
//  Created by Zevira varies martan on 09/05/22.
//
import UserNotifications
import UIKit

class AddScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        let date = models[indexPath.row].date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY h:mm a"
        cell.detailTextLabel?.text = formatter.string(from: date)
        
        return cell
    }
    
    
    @IBOutlet var scheduleTable: UITableView!
    
    var models =  [SleepSchedule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleTable.delegate = self
        scheduleTable.dataSource = self
        
    }
    
    @IBAction func didClickAdd () {
        //add the schedule
        guard let schedule = storyboard?.instantiateViewController(withIdentifier: "add") as? AddViewController else {
            return
        }
        
        schedule.title = "New Sleep Schedule"
        schedule.navigationItem.largeTitleDisplayMode = .never
        schedule.completion = { title, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = SleepSchedule(title: title, date: date, identifier: "id_\(title)")
                self.models.append(new)
                self.scheduleTable.reloadData()
                
                let content = UNMutableNotificationContent()
                content.title = "It's time to sleep!!"
                content.sound = .default
                content.body = title
                
                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
                let request = UNNotificationRequest(identifier: "long_id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong")
                    }
                })
            }
        }
        navigationController?.pushViewController(schedule, animated: true)
    }
    
    @IBAction func didClickNotif () {
        //test notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
                //schedule test
                self.scheduleTest()
            }
            else if error != nil {
                print("Error")
            }
        })
    }
    
    func scheduleTest() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder!"
        content.sound = .default
        content.body = "You have to sleep soon!!"
        
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "long_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print("something went wrong")
            }
        })
    }
}

struct SleepSchedule {
    let title: String
    let date: Date
    let identifier: String
}

