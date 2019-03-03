//
//  CalenderView + CollectionView.swift
//  SsgSag
//
//  Created by CHOMINJI on 02/02/2019.
//  Copyright © 2019 wndzlf. All rights reserved.
//

import Foundation

extension CalenderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //현재달의 표현해야하는 일자의 개수를 return한다.
        if numOfDaysInMonth[currentMonth-1] + firstWeekDayOfMonth - 1 > 35 {
            reValue = 42
        }else {
            reValue = 35
        }
        return reValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DayCollectionViewCell else {
            return .init()
        }
        
        var beforeMonthIndex = 0
        
        var beforeYear = 0 //이번달의 전 달이 어떤날에 해당하는지 확인!!
        
        var nextYear = 0
        
        var nextMonth = 0
        
        var nextMonthDay = 0
        
        if currentMonth == 1 { //이번달이 1월이면 이전달은 12월
            beforeMonthIndex = 12
            beforeYear = currentYear - 1
        } else {
            beforeMonthIndex = currentMonth - 1
            beforeYear = currentYear
        }
        
        var beforeMonthCount = numOfDaysInMonth[beforeMonthIndex-1]
        
        if beforeMonthIndex == 2 {
            if currentYear % 4 == 0 {
                beforeMonthCount = numOfDaysInMonth[beforeMonthIndex-1] + 1
            } else {
                beforeMonthCount = numOfDaysInMonth[beforeMonthIndex-1]
            }
        }
        
        if currentMonth == 12 {
            nextYear = currentYear + 1
            nextMonth = 1
        } else {
            nextYear = currentYear
            nextMonth = currentMonth + 1
        }
        
        let shouldShowBeforeMonthDay = indexPath.item <= firstWeekDayOfMonth - 2

        if shouldShowBeforeMonthDay { //이전달의 표현해야 하는 날짜들
            let beforeMonthDay = beforeMonthCount-firstWeekDayOfMonth+indexPath.row+2
            cell.isHidden = false
            cell.lbl.textColor = UIColor.rgb(red: 224, green: 224, blue: 224)
            cell.lbl.text = "\(beforeMonthDay)"
            cell.isUserInteractionEnabled = false
        } else {
            let shouldShowDay = indexPath.row-firstWeekDayOfMonth+2 //1~31일까지
            cell.isHidden = false
            cell.lbl.text = "\(shouldShowDay)"
            cell.isUserInteractionEnabled = true
            cell.lbl.textColor = Style.activeCellLblColor
            cell.lbl.backgroundColor = .clear
            
            if shouldShowDay == currentDay && currentYear == presentYear && currentMonth == presentMonthIndex { //오늘날짜
                todaysIndexPath = indexPath
                let lbl = cell.subviews[1] as! UILabel
                lbl.layer.cornerRadius = lbl.frame.height / 2
                lbl.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.7921568627, blue: 0.2862745098, alpha: 1)
                lbl.textColor = UIColor.white
            }
            
            if indexPath.row % 7 == 0 { //일요일
                cell.lbl.textColor = .red
            }
            
            nextMonthDay = (shouldShowDay + firstWeekDayOfMonth - 1) - (numOfDaysInMonth[currentMonth-1] + firstWeekDayOfMonth - 1)
            //다음달 일수 출력
            if nextMonthDay >= 1 {
                cell.isHidden = false
                cell.lbl.text="\(nextMonthDay)"
                cell.isUserInteractionEnabled = false
                cell.lbl.textColor = .lightGray
            }
            
        }
        
        var cellYear = currentYear
        var cellMonth = currentMonth
        var cellDay = indexPath.row - firstWeekDayOfMonth + 2
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var cellDateString = "\(cellYear)-\(cellMonth)-\(cellDay) 00:00:00"
        
        var currentCellDateTime = formatter.date(from: cellDateString)
        
        eventDictionary[indexPath.row] = []
        
        for posterTuple in posterTuples {
            //현재 셀의 연, 월 , 일 == tuple의 연 월 일이 모두 같아야만 그려준다.
            if let currentCellDate = currentCellDateTime {
                let currentCellYear = Calendar.current.component(.year, from: currentCellDate)
                let currentCellMonth = Calendar.current.component(.month, from: currentCellDate)
                let currentCellDay = Calendar.current.component(.day, from: currentCellDate)
                
                let currentPosterYear = Calendar.current.component(.year, from: posterTuple.endDate)
                let currentPosterMonth = Calendar.current.component(.month, from: posterTuple.endDate)
                let currentPosterDay = Calendar.current.component(.day, from: posterTuple.endDate)
                
                if (cellYear ==  currentPosterYear) && (cellMonth == currentPosterMonth) && (cellDay == currentPosterDay) {
                    
                    print("그려라라라라 \(currentCellDate) \(posterTuple.categoryIdx)  \(posterTuple.endDate.addingTimeInterval(60.0 * 60.0 * 9.0))")
                    
                    print("\(cellYear) \(cellMonth) \(currentCellDay) | \(currentPosterYear) \(currentPosterMonth) \(currentPosterDay) ")
                    
                    //Dictionary에 이벤트 추가
                    eventDictionary[indexPath.row]?.append(event.init(eventDate: posterTuple.endDate, title: posterTuple.title, categoryIdx: posterTuple.categoryIdx))
                }
            }
        }
        
//        let date1 = "2019-02-11 14:59:59"
//        let date2 = "2019-02-11 15:59:59"
//        let date3 = "2019-02-11 16:59:59"
//        let date4 = "2019-02-11 16:59:59"
//        let date5 = "2019-02-11 16:59:59"
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//        let endDate1 = dateFormatter.date(from: date1)!
//        let endDate2 = dateFormatter.date(from: date2)!
//        let endDate3 = dateFormatter.date(from: date3)!
//        let endDate4 = dateFormatter.date(from: date4)!
//        //let endDate5 = dateFormatter.date(from: date4)!
//
//        if indexPath.item == 15 {
//            eventDictionary[indexPath.row]?.append(event.init(eventDate: endDate1, title: "가가", categoryIdx: 1))
//
//            eventDictionary[indexPath.row]?.append(event.init(eventDate: endDate2, title: "니나", categoryIdx: 2))
//
//            eventDictionary[indexPath.row]?.append(event.init(eventDate: endDate3, title: "다다", categoryIdx: 3))
//
//            eventDictionary[indexPath.row]?.append(event.init(eventDate: endDate3, title: "라라", categoryIdx: 3))
//        }
        
        //eventDictionary[indexPath.row]?.append(event.init(eventDate: endDate3, title: "마마", categoryIdx: 3))
        
        
        
        cell.drawDotAndLineView(indexPath, eventDictionary: eventDictionary)
        
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        
        //다른달에 갔다 올때 오늘 날짜의 색
        if lastSelectedDate != nil && cellDay == currentDay && currentYear == presentYear && currentMonth == presentMonthIndex{
            todaysIndexPath = indexPath
            let lbl = cell.subviews[1] as! UILabel
            lbl.layer.cornerRadius = lbl.frame.height / 2
            lbl.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.7921568627, blue: 0.2862745098, alpha: 1)
            lbl.textColor = UIColor.white
        }
        
        if currentCellDateTime == nil {
            //전달이면
            if indexPath.row < 15 {
                cellYear = beforeYear
                cellMonth = beforeMonthIndex
                cellDay = beforeMonthCount-firstWeekDayOfMonth+indexPath.row+2
                
                cellDateString = "\(cellYear)-\(cellMonth)-\(cellDay) 00:00:00"
                currentCellDateTime = formatter.date(from: cellDateString)
            } else {
                cellYear = nextYear
                cellMonth = nextMonth
                cellDay = nextMonthDay
                
                cellDateString = "\(cellYear)-\(cellMonth)-\(cellDay) 00:00:00"
                currentCellDateTime = formatter.date(from: cellDateString)
            }
        }
        

        let calendar = Calendar.current
        let componentsCell = calendar.dateComponents([.year, .month, .day], from: currentCellDateTime!)
        
        if lastSelectedDate != nil {
            let componentsSelectedCell = calendar.dateComponents([.year, .month, .day], from: lastSelectedDate!)
            
            if componentsCell.month! == componentsSelectedCell.month! && componentsCell.year! == componentsSelectedCell.year!
                && componentsCell.day! == componentsSelectedCell.day! && todoButtonTapped == false {
                cell.lbl.backgroundColor = UIColor.lightGray
                cell.lbl.textColor = UIColor.white
            }
        }
    
        if indexPath == lastSelectedIndexPath && todoButtonTapped {
            cell.lbl.backgroundColor = UIColor.clear
            cell.lbl.textColor = UIColor.black
            todoButtonTapped = false
        }

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cellYear = currentYear
        let cellMonth = currentMonth
        let cellDay = indexPath.row - firstWeekDayOfMonth + 2
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let cellDateString = "\(cellYear)-\(cellMonth)-\(cellDay) 00:00:00"
        let currentCellDateTime = formatter.date(from: cellDateString)
        
        lastSelectedDate = currentCellDateTime//현재 선택된 셀의 date객체
        lastSelectedIndexPath = indexPath
        
        let userInfo = [ "currentCellDateTime" : currentCellDateTime ]
        
        //CalendarVC에 지금 선택된 날짜를 전송 안해도 되고 변수에 저장해 놓으면 됨
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didselectItem"), object: nil, userInfo: userInfo as [AnyHashable : Any])
        
    }
    
    //새로운 셀 선택시 이전셀 복구
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! DayCollectionViewCell
        let lbl = cell.subviews.last as! UILabel
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = Style.activeCellLblColor
        
        if indexPath.row % 7 == 0 { //일요일
            lbl.textColor = UIColor.red
            lbl.backgroundColor = UIColor.clear
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let currentDateString: String = "\(year)-\(month)-\(day) 00:00:00"
        let todayDate = formatter.date(from: currentDateString)
        
        if lastSelectedDate == todayDate{ //마지막 선택된 날짜가 오늘이라면
            lbl.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.7921568627, blue: 0.2862745098, alpha: 1)
            lbl.textColor = UIColor.white
        }
    }
    
}

//MARK:- CollectionView Layout
extension CalenderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //let width = collectionView.bounds.inset(by: collectionView.layoutMargins).width / 7
        
        let width = collectionView.frame.width / 7.1
        
        //var height = collectionView.bounds.inset(by: collectionView.layoutMargins).height / 7
        
        var height = collectionView.frame.height / 7.1
        
        if reValue == 35 {
            //height = collectionView.bounds.inset(by: collectionView.layoutMargins).height / 5
            height = collectionView.frame.height / 5.1
        } else {
            //height = collectionView.bounds.inset(by: collectionView.layoutMargins).height / 6
            height = collectionView.frame.height / 6.1
        }
        
        return CGSize(width: width, height: height)
    }
    
    //minimumLineSpacing  (세로)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    //minimumInteritemSpacing  (가로)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
