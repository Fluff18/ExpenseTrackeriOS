//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    // Follow the lifecycle of the app
    @StateObject var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
