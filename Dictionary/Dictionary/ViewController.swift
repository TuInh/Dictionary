//
//  ViewController.swift
//  Dictitionary2
//
//  Created by Tu Inh Le on 8/22/16.
//  Copyright © 2016 SummerLab. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK : IBOutlet
    @IBOutlet var tableView: UITableView!
    
    // variables
    static var isEdit = false
    let identifierVocabulary = "VocabularyCell"
    var vocabList :Results<VocabularyModel>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 15
        // Read Json Data and save in Realm
        readJsonData()
        // Retrieve data from Realm
        vocabList = realm.objects(VocabularyModel.self)
    }
    
    // View will appear when come back to MainView
    override func viewWillAppear(animated: Bool) {
        if ViewController.isEdit == true {
            //Reload value for tableview
            vocabList = realm.objects(VocabularyModel.self)
            tableView.reloadData()
            ViewController.isEdit = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // Read JSON data and write on Data Base Realm
    func readJsonData() {
        // Parse json data from file
        if let path = NSBundle.mainBundle().pathForResource("Data", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    let len = jsonObj.count
                    for index in 0...(len - 1) {
                        
                    guard let romanji = jsonObj[index,"romanji"].string else {
                            continue
                        }
                        guard let vietnamese = jsonObj[index,"vietnamese"].string else {
                            continue
                        }
                        guard let favourite = jsonObj[index,"favourite"].int else {
                            continue
                        }
                        guard let vocabularyID = jsonObj[index,"vocabularyID"].string else {
                            continue
                        }
                        guard let kanji = jsonObj[index,"kanji"].string else {
                            return
                        }
                        guard let furigana = jsonObj[index,"furigana"].string else {
                            continue
                        }
                        let newVocabulary = VocabularyModel()
                        newVocabulary.romanji = romanji
                        newVocabulary.vietnamese = vietnamese
                        newVocabulary.favourite = favourite
                        newVocabulary.vocabularyID = String(vocabularyID)
                        newVocabulary.kanji = kanji
                        newVocabulary.furigana = furigana
                        newVocabulary.ID = Int(vocabularyID)!
                        // Save Vocabulary to realm
                        try! realm.write {
                            realm.add(newVocabulary , update: true)
                        }
                    }
                    
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    // MARK:  UITableViewDataSource
    // number of section in TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocabList!.count
    }
    
    // number of row in section of TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // create cell for each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifierVocabulary, forIndexPath: indexPath) as! VocabularyTableViewCell
        let eachWord: VocabularyModel = vocabList![indexPath.row]
        cell.kanjiLabel.text = eachWord.kanji
        cell.vietnameseLabel.text = eachWord.vietnamese
        return cell
        
    }
    // MARK : Identify Segue to process jump to Detail
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditSegue" {
            let detailViewController:DetailViewController = segue.destinationViewController as! DetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            detailViewController.vocabularyModel = self.vocabList![(indexPath?.row)!]
            detailViewController.typeSegue = 2
        } else if segue.identifier == "AddSegue" {
            let detailViewController:DetailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.typeSegue = 1
        }
    }
}



