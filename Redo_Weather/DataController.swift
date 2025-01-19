//
//  DataController.swift
//  Redo_Weather
//
//  Created by user271431 on 1/4/25.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    var context = NSPersistentContainer(name: "WeatherModelData")
    
    init() {
        context.loadPersistentStores{desription, error in
            if error != nil {
                fatalError("Error in loading")
            } else {
                print("Successfully loaded")
            }
        }
    }
}
