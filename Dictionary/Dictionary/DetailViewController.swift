//
//  DetailViewController.swift
//  Dictitionary2
//
//  Created by Tu Inh Le on 8/21/16.
//  Copyright © 2016 SummerLab. All rights reserved.
import UIKit
import RealmSwift
class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Declare Variables
    let realm = try! Realm()
    let identifierDetailVocabulary = "VocabularyDetailCell"
    var vocabularyModel:VocabularyModel? = nil
    var typeSegue = 1
    
    // MARK : IBOutlet and IBAction
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var editBarButtonItem: UIBarButtonItem!
    
    @IBAction func editAction(sender: AnyObject) {
        let kanji = getTextAtRowIndex(0)
        let furigana = getTextAtRowIndex(1)
        let vietnamese = getTextAtRowIndex(2)
        let romanji = getTextAtRowIndex(3)
        if typeSegue == 1 {
            // Add new word
            ViewController.isEdit = true
            let newVocabulary = VocabularyModel()
            newVocabulary.kanji = kanji
            newVocabulary.furigana = furigana
            newVocabulary.vietnamese = vietnamese
            newVocabulary.romanji = romanji
            newVocabulary.favourite = 0
            let arr = realm.objects(VocabularyModel.self).sorted("ID", ascending: false)
            if arr.count > 0{
                newVocabulary.ID = arr[0].ID + 1
                newVocabulary.vocabularyID = String(newVocabulary.ID)
                // add new vocalbulary into realm
                try! realm.write {
                    realm.add(newVocabulary , update: true)
                }
            }
        } else if typeSegue == 2 {
            //TextField become editable
            typeSegue = 3
            editBarButtonItem.title = "Done"
        } else if typeSegue == 3 {
            // Save word in Realm after edit
            typeSegue = 2
            editBarButtonItem.title = "Edit"
            ViewController.isEdit = true
            let idVocabulary = vocabularyModel?.ID
            let vocabulary = realm.objects(VocabularyModel.self).filter("ID == %d",idVocabulary!)[0]
            try! realm.write {
                vocabulary.kanji = kanji
                vocabulary.furigana = furigana
                vocabulary.vietnamese = vietnamese
                vocabulary.romanji = romanji
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.rowHeight = UITableViewAutomaticDimension
        detailTableView.estimatedRowHeight = 15.0
        
        // Do any additional setup after loading the view.
        if typeSegue == 1 {
            editBarButtonItem.title = "Save"
        } else if typeSegue == 2 {
            editBarButtonItem.title = "Edit"
        } else if typeSegue == 3 {
            editBarButtonItem.title = "Done"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // get text from uitableviewcell to save in Real
    func getTextAtRowIndex(index: Int) -> String {
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        let editString = (detailTableView.cellForRowAtIndexPath(indexPath) as! DetailTableViewCell).meaningTextField.text!
        return editString
    }
    // MARK:  UITableViewDataSource
    // number of section in TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // number of row in section of TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // create cell for each row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure for 4 cells
        let cell = tableView.dequeueReusableCellWithIdentifier(identifierDetailVocabulary, forIndexPath: indexPath) as! DetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.typeLabel.text = "漢字"
            cell.meaningTextField.text = vocabularyModel?.kanji
            break
        case 1:
            cell.typeLabel.text = "ふりがな"
            cell.meaningTextField.text = vocabularyModel?.furigana
            break
        case 2:
            cell.typeLabel.text = "vietnamese"
            cell.meaningTextField.text = vocabularyModel?.vietnamese
            break
        case 3:
            cell.typeLabel.text = "romanji"
            cell.meaningTextField.text = vocabularyModel?.romanji
            break
            
        default:
            break
        }
        return cell
    }
}
