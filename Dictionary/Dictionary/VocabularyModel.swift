//
//  VocabularyModel.swift
//  Dictionary
//
//  Created by Tu Inh Le on 8/22/16.
//  Copyright © 2016 Quoc Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class VocabularyModel: Object {
  
  dynamic var romanji = ""
  dynamic var vietnamese = ""
  dynamic var favourite = 0
  dynamic var vocabularyID = ""
  dynamic var kanji = ""
  dynamic var furigana = ""
  dynamic var ID = -1

  override static func primaryKey() -> String? {
    return "ID"
  }

  
}
