//
//  AppDelegate.swift
//  States
//
//  Created by Nikhil Krishnaswamy on 6/7/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private func seedCoreData() {
        let context = persistentContainer.viewContext
        
        // Check if the data has already been seeded
        let fetchRequest: NSFetchRequest<ListItem> = ListItem.fetchRequest()
        do {
            let count = try context.count(for: fetchRequest)
            if count > 0 {
                // Data has already been seeded, no need to continue
                return
            }
        } catch {
            print("Failed to fetch data count: \(error)")
            return
        }
        
        // Create and seed the initial data
        let states = [
            States(name: "Alabama", abbreviation: "AL", flagImageName: "alabama_flag", stateSealImageName: "alabama_seal", capitalCity: "Montgomery", largestCity: "Birmingham", population: "4.9 million", area: "52,419 sq mi"),
            States(name: "Alaska", abbreviation: "AK", flagImageName: "alaska_flag", stateSealImageName: "alaska_seal", capitalCity: "Juneau", largestCity: "Anchorage", population: "731,545", area: "663,267 sq mi"),
            States(name: "Arizona", abbreviation: "AZ", flagImageName: "arizona_flag", stateSealImageName: "arizona_seal", capitalCity: "Phoenix", largestCity: "Phoenix", population: "7.3 million", area: "113,990 sq mi"),
            States(name: "Arkansas", abbreviation: "AR", flagImageName: "arkansas_flag", stateSealImageName: "arkansas_seal", capitalCity: "Little Rock", largestCity: "Little Rock", population: "3 million", area: "53,179 sq mi"),
            States(name: "California", abbreviation: "CA", flagImageName: "california_flag", stateSealImageName: "california_seal", capitalCity: "Sacramento", largestCity: "Los Angeles", population: "39.5 million", area: "163,696 sq mi"),
            States(name: "Colorado", abbreviation: "CO", flagImageName: "colorado_flag", stateSealImageName: "colorado_seal", capitalCity: "Denver", largestCity: "Denver", population: "5.8 million", area: "104,094 sq mi"),
            States(name: "Connecticut", abbreviation: "CT", flagImageName: "connecticut_flag", stateSealImageName: "connecticut_seal", capitalCity: "Hartford", largestCity: "Bridgeport", population: "3.6 million", area: "5,543 sq mi"),
            States(name: "Delaware", abbreviation: "DE", flagImageName: "delaware_flag", stateSealImageName: "delaware_seal", capitalCity: "Dover", largestCity: "Wilmington", population: "989,948", area: "1,949 sq mi"),
            States(name: "Florida", abbreviation: "FL", flagImageName: "florida_flag", stateSealImageName: "florida_seal", capitalCity: "Tallahassee", largestCity: "Jacksonville", population: "21.5 million", area: "65,757 sq mi"),
            States(name: "Georgia", abbreviation: "GA", flagImageName: "georgia_flag", stateSealImageName: "georgia_seal", capitalCity: "Atlanta", largestCity: "Atlanta", population: "10.6 million", area: "59,425 sq mi"),
            States(name: "Hawaii", abbreviation: "HI", flagImageName: "hawaii_flag", stateSealImageName: "hawaii_seal", capitalCity: "Honolulu", largestCity: "Honolulu", population: "1.4 million", area: "10,931 sq mi"),
            States(name: "Idaho", abbreviation: "ID", flagImageName: "idaho_flag", stateSealImageName: "idaho_seal", capitalCity: "Boise", largestCity: "Boise", population: "1.8 million", area: "83,569 sq mi"),
            States(name: "Illinois", abbreviation: "IL", flagImageName: "illinois_flag", stateSealImageName: "illinois_seal", capitalCity: "Springfield", largestCity: "Chicago", population: "12.8 million", area: "57,914 sq mi"),
            States(name: "Indiana", abbreviation: "IN", flagImageName: "indiana_flag", stateSealImageName: "indiana_seal", capitalCity: "Indianapolis", largestCity: "Indianapolis", population: "6.7 million", area: "36,418 sq mi"),
            States(name: "Iowa", abbreviation: "IA", flagImageName: "iowa_flag", stateSealImageName: "iowa_seal", capitalCity: "Des Moines", largestCity: "Des Moines", population: "3.2 million", area: "56,272 sq mi"),
            States(name: "Kansas", abbreviation: "KS", flagImageName: "kansas_flag", stateSealImageName: "kansas_seal", capitalCity: "Topeka", largestCity: "Wichita", population: "2.9 million", area: "82,278 sq mi"),
            States(name: "Kentucky", abbreviation: "KY", flagImageName: "kentucky_flag", stateSealImageName: "kentucky_seal", capitalCity: "Frankfort", largestCity: "Louisville", population: "4.5 million", area: "40,409 sq mi"),
            States(name: "Louisiana", abbreviation: "LA", flagImageName: "louisiana_flag", stateSealImageName: "louisiana_seal", capitalCity: "Baton Rouge", largestCity: "New Orleans", population: "4.6 million", area: "52,378 sq mi"),
            States(name: "Maine", abbreviation: "ME", flagImageName: "maine_flag", stateSealImageName: "maine_seal", capitalCity: "Augusta", largestCity: "Portland", population: "1.3 million", area: "35,385 sq mi"),
            States(name: "Maryland", abbreviation: "MD", flagImageName: "maryland_flag", stateSealImageName: "maryland_seal", capitalCity: "Annapolis", largestCity: "Baltimore", population: "6.2 million", area: "12,407 sq mi"),
            States(name: "Massachusetts", abbreviation: "MA", flagImageName: "massachusetts_flag", stateSealImageName: "massachusetts_seal", capitalCity: "Boston", largestCity: "Boston", population: "6.9 million", area: "10,565 sq mi"),
            States(name: "Michigan", abbreviation: "MI", flagImageName: "michigan_flag", stateSealImageName: "michigan_seal", capitalCity: "Lansing", largestCity: "Detroit", population: "10 million", area: "96,716 sq mi"),
            States(name: "Minnesota", abbreviation: "MN", flagImageName: "minnesota_flag", stateSealImageName: "minnesota_seal", capitalCity: "St. Paul", largestCity: "Minneapolis", population: "5.7 million", area: "86,936 sq mi"),
            States(name: "Mississippi", abbreviation: "MS", flagImageName: "mississippi_flag", stateSealImageName: "mississippi_seal", capitalCity: "Jackson", largestCity: "Jackson", population: "2.9 million", area: "48,430 sq mi"),
            States(name: "Missouri", abbreviation: "MO", flagImageName: "missouri_flag", stateSealImageName: "missouri_seal", capitalCity: "Jefferson City", largestCity: "Kansas City", population: "6.1 million", area: "69,709 sq mi")
            // Add more states here...
        ]
        
        for state in states {
            let listItem = ListItem(context: context)
            listItem.name = state.name
            listItem.abbreviation = state.abbreviation
            listItem.flagImageName = state.flagImageName
            listItem.stateSealImageName = state.stateSealImageName
            listItem.capitalCity = state.capitalCity
            listItem.largestCity = state.largestCity
            listItem.population = state.population
            listItem.area = state.area
        }
        
        // Save the changes
        do {
            try context.save()
        } catch {
            print("Failed to save initial data: \(error)")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        seedCoreData()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "States")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

