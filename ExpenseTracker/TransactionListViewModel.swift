//
//  TransactionListViewModel.swift
//  ExpenseTracker
//

import Foundation
import Combine
import Collections

typealias TransactionGrroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]


final class TransactionListViewModel: ObservableObject {
    //@published send when value changes
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            // As UI channges have to be made
            .receive(on: DispatchQueue.main)
            //Process data
            .sink{ completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions: ", error.localizedDescription)
                case .finished:
                    print("Finised fetching transactions")
                }
                    //prevents mem leaks
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions)
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionByMonth() -> TransactionGrroup {
        guard !transactions.isEmpty else { return[:] }
        
        let groupedTrans = TransactionGrroup(grouping: transactions) { $0.month }
        return groupedTrans
        
    }
    
    
    func accumulateTransac() -> TransactionPrefixSum {
        
        print("accumulateTransactions")
        guard !transactions.isEmpty else { return [] }
        let today = "02/17/2022".dateParser()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("dateInterval", dateInterval)
        
        var sum: Double = .zero
        var total = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, through: today, by: 3600*24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount}
            
            sum += dailyTotal
            sum = sum.roundedto2()
            total.append((date.formatted(), sum))
            print(date.formatted(), dailyTotal, sum)
            
        }
        return total
    }
    
}
