
import UIKit

class CalenderVC: UIViewController{
    var todoStatus = 1
    
    var daySelectedStatus = 0
    
    var todoTableData:[(Date, Date, Int, Int, String, Int)] = []
    
    var posterTuples:[(Date, Date, Int, Int, String, Int)] = []
    
    let calenderView: CalenderView = {
        let v = CalenderView(theme: MyTheme.light)
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()

    let todoSeparatorBar: UIView = {
        let todoView = UIView()
        todoView.backgroundColor = UIColor.rgb(red: 228, green: 228, blue: 228)
        todoView.translatesAutoresizingMaskIntoConstraints = false
        return todoView
    }()
    
    let todoTableView: UITableView = {
        let todo = UITableView()
        todo.showsVerticalScrollIndicator = false
        todo.translatesAutoresizingMaskIntoConstraints = false
        return todo
    }()
    
    /* 일정 수동 추가 버튼
    let passiveScheduleAddButton : UIButton = {
        let bt = UIButton()
        bt.setImage(#imageLiteral(resourceName: "btnFloatingPlus"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        //bt.backgroundColor = UIColor(displayP3Red: 7 / 255, green: 166 / 255, blue: 255 / 255, alpha: 1.0)
        return bt
    }()
    */
    
    let tabToDownButtonView: UIImageView = {
        let downView = UIImageView()
        downView.translatesAutoresizingMaskIntoConstraints = false
        downView.image = UIImage(named: "icListTabDown")
        return downView
    }()
    
    let todoList: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.text = "투두리스트"
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        return label
    }()
    
    let separatorLine: UIView = {
        let separ = UIView()
        separ.translatesAutoresizingMaskIntoConstraints = false
        return separ
    }()
    
    let todoListButton: UIButton = {
        let tb = UIButton()
        tb.setImage(UIImage(named: "icTodolistBtn"), for: .normal)
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //calenderView.calendarCollectionView.collectionViewLayout.invalidateLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Style.bgColor
        
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "todoStatus"), object: nil)
        setupContentView()
        setupGesture()
        
        //userDefaults 더하는 것에 요청함
        NotificationCenter.default.addObserver(self, selector: #selector(addUserDefaults), name: NSNotification.Name("addUserDefaults"), object: nil)
        //todoTable의 변화를 받음
        NotificationCenter.default.addObserver(self, selector: #selector(dayDidSelected(_:)), name: NSNotification.Name(rawValue: "todoUpByDaySelected"), object: nil)
        
        bringUserDefaultsAndSetPosetTupels()
        posterTuples.sort{$0.1 < $1.1}
        addtoTODOTable()
//        viewWillLayoutSubviews()
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let color1 = UIColor.rgb(red: 251, green: 251, blue: 251)
        let color2 = UIColor.rgb(red: 249, green: 249, blue: 249)
        let color3 = UIColor.rgb(red: 246, green: 246, blue: 246)
       
        todoSeparatorBar.setGradientBackGround(colorOne: color1, colorTwo: color2, frame: todoSeparatorBar.bounds)
//        todoList.setGradientBackGround(colorOne: color1, colorTwo: color2, frame: todoList.bounds)
        let bgView = UIView(frame: todoTableView.bounds)
        bgView.setGradientBackGround(colorOne: color2, colorTwo: color3, frame: todoTableView.bounds)
        todoTableView.backgroundView = bgView
    }
    
    
    func isDuplicatePosterTuple(_ posterTuples:[(Date, Date, Int, Int, String, Int)], input: (Date, Date, Int, Int, String, Int)) -> Bool {
        for i in posterTuples {
            if i.4 == input.4 {
                return true
            }
        }
        return false
    }
    
    //여기서 중복 되는 것을 거르자.
    @objc func addUserDefaults() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let posterTupleFromCalendarView = calenderView.posterTuples
        
        let today = Date()
        
        for posterTuple in posterTupleFromCalendarView {
            let posterTupleMonth = Calendar.current.component(.month, from: posterTuple.1)
            let posterTupleDay = Calendar.current.component(.day, from: posterTuple.1)
            
            let todayMonth = Calendar.current.component(.month, from: today)
            let todayDay = Calendar.current.component(.day, from: today)
            
            if posterTupleMonth == todayMonth && (posterTupleDay - todayDay) > 0{
                if isDuplicatePosterTuple(todoTableData, input: posterTuple) == false {
                        todoTableData.append(posterTuple)
                }
            }
        }
        todoTableView.reloadData()
    }
    
    func setupContentView() {
        view.addSubview(todoTableView)
        view.addSubview(todoSeparatorBar)
        
        todoSeparatorBar.addSubview(tabToDownButtonView)
        todoSeparatorBar.addSubview(todoList)
        todoSeparatorBar.addSubview(separatorLine)
        view.addSubview(calenderView)
        view.addSubview(todoListButton)
        
        NSLayoutConstraint.activate([
            todoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            todoTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            todoSeparatorBar.bottomAnchor.constraint(equalTo: todoTableView.topAnchor),
            todoSeparatorBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            todoSeparatorBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            todoSeparatorBar.heightAnchor.constraint(equalToConstant: 45),
            
            todoList.leadingAnchor.constraint(equalTo: todoSeparatorBar.leadingAnchor, constant: 18),
            todoList.bottomAnchor.constraint(equalTo: todoSeparatorBar.bottomAnchor),
            todoList.centerYAnchor.constraint(equalTo: todoSeparatorBar.centerYAnchor),
            
            tabToDownButtonView.centerYAnchor.constraint(equalTo: todoSeparatorBar.centerYAnchor),
            tabToDownButtonView.leadingAnchor.constraint(equalTo: todoList.trailingAnchor, constant: 13),
            
            separatorLine.bottomAnchor.constraint(equalTo: todoSeparatorBar.topAnchor),
            separatorLine.leftAnchor.constraint(equalTo: todoSeparatorBar.leftAnchor),
            separatorLine.rightAnchor.constraint(equalTo: todoSeparatorBar.rightAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
        
            calenderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            calenderView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.45),
            calenderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            calenderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            calenderView.bottomAnchor.constraint(equalTo: todoSeparatorBar.topAnchor),
            
            todoListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:-34),
            todoListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            todoListButton.widthAnchor.constraint(equalToConstant: 135),
            todoListButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
//        todoTableView.rowHeight = view.frame.height / 13
//        todoTableView.rowHeight = todoTableView.frame.height / 3.5
        todoTableView.dataSource = self
        todoTableView.delegate = self
        todoTableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "todoCell")
        
        todoTableView.separatorStyle = .none
        separatorLine.backgroundColor = UIColor.rgb(red: 228, green: 228, blue: 228)
        
        todoListButton.isHidden = true
        todoListButton.addTarget(self, action: #selector(changeTodoTable), for: .touchUpInside)
        
        todoList.text = "투두리스트"
        
        /*
         view.addSubview(passiveScheduleAddButton)
         view.bringSubviewToFront(passiveScheduleAddButton)
         passiveScheduleAddButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
         passiveScheduleAddButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
         passiveScheduleAddButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
         passiveScheduleAddButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
         passiveScheduleAddButton.layer.cornerRadius = 54 / 2
         passiveScheduleAddButton.layer.masksToBounds = true
         passiveScheduleAddButton.addTarget(self, action: #selector(addPassiveDate), for: .touchUpInside)
         */
    }
    
    func setupGesture() {
        let todoTableShow = UISwipeGestureRecognizer(target: self, action: #selector(todoTableSwipeUp))
        let todoTableSwipeHide = UISwipeGestureRecognizer(target: self, action: #selector(hideTodoTable))
        let todoTableHide = UITapGestureRecognizer(target: self, action: #selector(hideTodoTable))
        
        let movePreviousMonth = UISwipeGestureRecognizer(target: self, action: #selector(movePreviousMonthBySwipe))
        let moveNextMonth = UISwipeGestureRecognizer(target: self, action: #selector(moveNextMonthBySwipe))
        
        calenderView.gestureRecognizers = [movePreviousMonth, moveNextMonth, todoTableShow, todoTableSwipeHide]
        
        movePreviousMonth.direction = .left
        moveNextMonth.direction = .right
        todoTableShow.direction = .up
        todoTableSwipeHide.direction = .down
        
        todoSeparatorBar.gestureRecognizers = [todoTableHide]
    }
    
    private func addtoTODOTable() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let today = Date()
        for i in posterTuples {
            let posterTupleMonth = Calendar.current.component(.month, from: i.1)
            let posterTupleDay = Calendar.current.component(.day, from: i.1)
            
            let todayMonth = Calendar.current.component(.month, from: today)
            let todayDay = Calendar.current.component(.day, from: today)
            
            if posterTupleMonth == todayMonth && (posterTupleDay - todayDay) > 0 {
                if isDuplicatePosterTuple(todoTableData, input: i) == false {
                    todoTableData.append(i)
                }
            }
        }
    }
    
    private func bringUserDefaultsAndSetPosetTupels(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let defaults = UserDefaults.standard
        
        if let posterData = defaults.object(forKey: "poster") as? Data {
            if let posterInfo = try? PropertyListDecoder().decode([Posters].self, from: posterData){
                for poster in posterInfo {
                    let posterStartDateTime = formatter.date(from: poster.posterStartDate!)
                    let posterEndDateTime = formatter.date(from: poster.posterEndDate!)
                    
                    let components = Calendar.current.dateComponents([.day], from: posterStartDateTime!, to: posterEndDateTime!)
                    let dayInterval = components.day! + 1
                    
                    if isDuplicatePosterTuple(posterTuples, input: ((posterStartDateTime!, posterEndDateTime!, dayInterval, poster.categoryIdx!, poster.posterName!, poster.categoryIdx!))) == false {
                        posterTuples.append((posterStartDateTime!, posterEndDateTime!, dayInterval, poster.categoryIdx!, poster.posterName!, poster.categoryIdx!))
                    }
                }
            }
        }
    }
    
    fileprivate func getDateAfterToday(_ today: Date) {
        for i in posterTuples {
            let posteurTupleMonth = Calendar.current.component(.month, from: i.1)
            let posterTupleDay = Calendar.current.component(.day, from: i.1)
            
            let todayMonth = Calendar.current.component(.month, from: today)
            let todayDay = Calendar.current.component(.day, from: today)
            
            if posteurTupleMonth == todayMonth && (posterTupleDay - todayDay) > 0{
                if isDuplicatePosterTuple(todoTableData, input: i) == false {
                    todoTableData.append(i)
                }
            }
        }
    }
    
    @objc func changeTodoTable() {
        daySelectedStatus = 0
        todoListButton.isHidden = true
        todoTableData = []
        let today = Date()
        getDateAfterToday(today)
        
        NotificationCenter.default.post(name: NSNotification.Name("changeTodoTableStatusByButton"), object: nil)
        todoList.text = "투두리스트"
        
        todoTableView.reloadData()
    }
    
    //날짜 선택시 실행
    @objc func dayDidSelected(_ notification: Notification) {
        daySelectedStatus += 1
        NotificationCenter.default.post(name: NSNotification.Name("rightItemHidden"), object: nil)
        
        todoUpByDaySelected(notification)
    }
    
    @objc func addPassiveDate() {
        let storyboard = UIStoryboard(name: "Calendar", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "AddPassiveDateNV")
        present(nav, animated: true, completion: nil)
    }
    
    @objc func todoTableSwipeUp(){
        setCalendarVCWhenTODOShow()
        NotificationCenter.default.post(name: NSNotification.Name("changeToUp"), object: nil)
        
        if daySelectedStatus == 0 {
            todoTableData = []
            let today = Date()
            for i in posterTuples {
                let posteurTupleMonth = Calendar.current.component(.month, from: i.1)
                let posterTupleDay = Calendar.current.component(.day, from: i.1)
                
                let todayMonth = Calendar.current.component(.month, from: today)
                let todayDay = Calendar.current.component(.day, from: today)
                
                if posteurTupleMonth == todayMonth && (posterTupleDay - todayDay) > 0{
                    todoTableData.append(i)
                }
            }
            self.todoListButton.isHidden = true
            self.todoTableView.reloadData()
        }
        todoStatus = -1
        calenderView.calendarCollectionView.reloadData()
    }
    
    func setCalendarVCWhenTODOShow() {
        for subview in view.subviews {
            if subview == calenderView {
                subview.removeFromSuperview()
            }
        }
        
        print("contentOffset \(calenderView.calendarCollectionView.contentOffset.y)")
        
        view.addSubview(todoTableView)
        view.addSubview(todoSeparatorBar)
        view.addSubview(calenderView)
        todoSeparatorBar.addSubview(separatorLine)
        
        
        NSLayoutConstraint.activate([
            todoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            todoTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            todoSeparatorBar.bottomAnchor.constraint(equalTo: todoTableView.topAnchor),
            todoSeparatorBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            todoSeparatorBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            todoSeparatorBar.heightAnchor.constraint(equalToConstant: 45),
            
            separatorLine.bottomAnchor.constraint(equalTo: todoSeparatorBar.topAnchor),
            separatorLine.leftAnchor.constraint(equalTo: todoSeparatorBar.leftAnchor),
            separatorLine.rightAnchor.constraint(equalTo: todoSeparatorBar.rightAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            calenderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            calenderView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.45),
            calenderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            calenderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            calenderView.bottomAnchor.constraint(equalTo: todoSeparatorBar.topAnchor),
            
            ])
        
        todoTableView.rowHeight = todoTableView.frame.height / 3.5
        todoTableView.dataSource = self
        todoTableView.delegate = self
        todoTableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "todoCell")
        
        
        view.bringSubviewToFront(todoListButton)
        todoListButton.isHidden = false
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
        
//        self.calenderView.calendarCollectionView.reloadData()
    }
    
    //
    @objc func todoUpByDaySelected(_ notification: Notification){
        setCalendarVCWhenTODOShow()
        NotificationCenter.default.post(name: NSNotification.Name("changeToUp"), object: nil)
        //마지막 선택된 날짜로 투두 테이블 표현
        if let currentSelectedDateTime = notification.userInfo?["currentCellDateTime"] as? Date {
            
            todoTableData = []
            
            for posterTuple in posterTuples {
                //posterTuple의 연,월,일이 모두 같을때만 todoTableData에 값을 넣는다.
                
                let posterTupleEndDateYear = Calendar.current.component(.year, from: posterTuple.1)
                let posterTupleEndDateMonth = Calendar.current.component(.month, from: posterTuple.1)
                let posterTupleEndDateDay = Calendar.current.component(.day, from: posterTuple.1)
                
                let currentSelectedDateYear = Calendar.current.component(.year, from: currentSelectedDateTime)
                let currentSelectedDateMonth = Calendar.current.component(.month, from: currentSelectedDateTime)
                let currentSelectedDateDay = Calendar.current.component(.day, from: currentSelectedDateTime)

                if posterTupleEndDateYear == currentSelectedDateYear && posterTupleEndDateMonth == currentSelectedDateMonth && posterTupleEndDateDay == currentSelectedDateDay {
                    todoTableData.append(posterTuple)
                }
                
//                if posterTuple.0 <= currentSelectedDateTime && posterTuple.1 >= currentSelectedDateTime {
//                    todoTableData.append(posterTuple)
//                }
            }
            
            let currentCellMonth = Calendar.current.component(.month, from: currentSelectedDateTime)
            let currentCellDay = Calendar.current.component(.day, from: currentSelectedDateTime)
            
            let currentDateString = "\(currentCellMonth)월 \(currentCellDay)일"
            todoList.text = currentDateString
            print("todoList날짜: \(currentDateString)")
            todoSeparatorBar.bringSubviewToFront(todoList)
            todoTableView.reloadData()
        }
        
        todoStatus = -1
        calenderView.calendarCollectionView.reloadData()
        print("contentOffset \(calenderView.calendarCollectionView.contentOffset.y)")
    }
    
    func setCalendarVCWhenTODOHide() {
        NotificationCenter.default.post(name: NSNotification.Name("changeToDown"), object: nil)
        
        for subview in view.subviews {
            if subview == todoTableView || subview == todoSeparatorBar {
                subview.removeFromSuperview()
            }
        }
    
        
        calenderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        calenderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        todoListButton.isHidden = true
        
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
            //self.calenderView.calendarCollectionView.reloadData()
        }
    }
    
    @objc func hideTodoTable(){
        setCalendarVCWhenTODOHide()
        todoStatus = 1
        calenderView.calendarCollectionView.reloadData()
    }
    
    @objc func moveNextMonthBySwipe() {
        hideTodoTable()
        calenderView.monthView.rightPanGestureAction()
    }
    
    @objc func movePreviousMonthBySwipe() {
        hideTodoTable()
        calenderView.monthView.leftPanGestureAction()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.calendarCollectionView.collectionViewLayout.invalidateLayout()
    }
}

fileprivate extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

