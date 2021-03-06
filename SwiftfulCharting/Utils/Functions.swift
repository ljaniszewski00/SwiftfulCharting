//
//  Functions.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 29/05/2022.
//

import Foundation

func getDateFrom(date: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: date)!
}

func convertDateToStringDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}

func addDaysToDate(days: Int, date: Date) -> Date {
    var dateComponent = DateComponents()
    dateComponent.day = days
    return Calendar.current.date(byAdding: dateComponent, to: date)!
}
