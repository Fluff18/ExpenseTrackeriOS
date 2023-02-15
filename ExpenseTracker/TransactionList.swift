//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Luminosity on 2/14/23.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListView: TransactionListViewModel
    var body: some View {
        VStack {
            List {
                // MARK: Transaction Groups
                ForEach(Array(transactionListView.groupTransactionByMonth()), id: \.key) { month, transactions in
                    Section {
                        //MARK: Transac list
                        ForEach(transactions) { transac in
                            
                            TransactionRow(transaction: transac)
                        }
                    } header: {
                        //MARK: Transac month
                        Text(month)
                        
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct TransactionList_Previews: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group {
            NavigationView {
                TransactionList()
            }
            NavigationView {
                TransactionList()
                    .preferredColorScheme(.dark)
            }
        }
        .environmentObject((transactionListVM))
    }
}
