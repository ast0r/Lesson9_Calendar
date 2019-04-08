//
//  CalendarDataSource.swift
//  Lesson9_Calendar
//
//  Created by Pavel Ivanov on 4/5/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import Foundation

class CalendarDataSource{
    
    lazy var calendar: Calendar = {
        var gregorian = Calendar.init(identifier: .gregorian)
        gregorian.locale = Locale.current
        gregorian.firstWeekday = 2
        return gregorian
    }()
    
    //MARK: - Month
    func numberOfMonth() -> NSInteger {
        return calendar.monthSymbols.count
    }
    
    func titleOfMonth(for section: Int) -> String {
        let items = calendar.monthSymbols
        
        if (section < items.count) {
            return items[section]
        }
        
        return ""
    }
    //MARK: - Days
    
    func numberOfDaysInMonth(for month: Int) -> Int {
        
        let firstDate = getFirstDayOfMonth(for: month)
        
        let weekday = numberOfDaysInWeek(for: firstDate)
        print(weekday)
        
        if let range = calendar.range(of: .day, in: .month, for: firstDate) {
            return range.count + ( weekday - 1) 
        }
        
        return 0
    }
    
    func numberOfPrevDaysInMonth(for month: Int) -> Int {
        
        let firstDate = getFirstDayOfMonth(for: month)
        let weekday = numberOfDaysInWeek(for: firstDate)                
        return (weekday - 1)
    }
    
    fileprivate func getFirstDayOfMonth(for month: Int) -> Date {
        
        let calendarComponents : Set<Calendar.Component> = [ .year, .month, .day]
        
        var components = calendar.dateComponents(calendarComponents, from: Date())
        
        components.month = month
        components.day = 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        if let firstDate = calendar.date(from: components) {
            return firstDate
        }
        
        return Date()
    }
    
    func numberOfDaysInWeek(for date: Date) -> Int {
        
        if let weekDay = calendar.ordinality(of: .weekday, in: .weekOfMonth, for: date) {
            
            return weekDay
        }
        
        return 0
    }
    
}
