
enum todoTableStatus: Int {
    case todoShow = -1
    case todoNotShow = 1
}

//날짜 하나에 해당하는 셀
class DayCollectionViewCell: UICollectionViewCell {
    
    var todoStatus: todoTableStatus = .todoShow
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeToUp), name: NSNotification.Name("changeToUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeToDown), name: NSNotification.Name("changeToDown"), object: nil)
        
        setupViews()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        if todoStatus == .todoShow {

            dotAndLineView1.circleView()
            dotAndLineView2.circleView()
            dotAndLineView3.circleView()
            dotAndLineView4.circleView()
            dotAndLineView5.circleView()
            
        } else {
            
            dotAndLineView1.applyRadius(radius: 0)
            dotAndLineView2.applyRadius(radius: 0)
            dotAndLineView3.applyRadius(radius: 0)
            dotAndLineView4.applyRadius(radius: 0)
            dotAndLineView5.applyRadius(radius: 0)
        }
    }
    
    @objc func changeToUp() {
        todoStatus = .todoShow
        reloadInputViews()
    }
    
    @objc func changeToDown() {
        todoStatus = .todoNotShow
    }
    
    private lazy var cellWidth = self.frame.width * 0.1
    
    var dotAndLineView1TopAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView1WidthAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView1HeightAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView1CenterXAnchor: NSLayoutConstraint = NSLayoutConstraint()
    
    var dotAndLineView2TopAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView2WidthAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView2HeightAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView2CenterXAnchor: NSLayoutConstraint = NSLayoutConstraint()
    
    var dotAndLineView3TopAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView3WidthAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView3HeightAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView3CenterXAnchor: NSLayoutConstraint = NSLayoutConstraint()
    
    var dotAndLineView4TopAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView4WidthAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView4HeightAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView4CenterXAnchor: NSLayoutConstraint = NSLayoutConstraint()
    
    var dotAndLineView5TopAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView5WidthAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView5HeightAnchor: NSLayoutConstraint = NSLayoutConstraint()
    var dotAndLineView5CenterXAnchor: NSLayoutConstraint = NSLayoutConstraint()
    
    //날짜 텍스트
    func setupViews() {
        addSubview(lbl)
        lbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        lbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lbl.widthAnchor.constraint(equalTo: lbl.heightAnchor).isActive = true
        
        lbl.layer.cornerRadius = lbl.frame.width / 2
        
        bringSubviewToFront(lbl)
    
        addSubview(dotAndLineView1)
        addSubview(dotAndLineView2)
        addSubview(dotAndLineView3)
        addSubview(dotAndLineView4)
        addSubview(dotAndLineView5)
        
        dotAndLineView1TopAnchor = dotAndLineView1.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 4)
        dotAndLineView1WidthAnchor = dotAndLineView1.widthAnchor.constraint(equalToConstant: dotWidth)
        dotAndLineView1HeightAnchor = dotAndLineView1.heightAnchor.constraint(equalToConstant: dotWidth)
        dotAndLineView1CenterXAnchor = NSLayoutConstraint(item: dotAndLineView1, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -6)
        
        
        dotAndLineView2TopAnchor = dotAndLineView2.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 4)
        dotAndLineView2WidthAnchor = dotAndLineView2.widthAnchor.constraint(equalToConstant: dotWidth)
        dotAndLineView2HeightAnchor = dotAndLineView2.heightAnchor.constraint(equalToConstant: dotWidth)
        dotAndLineView2CenterXAnchor = NSLayoutConstraint(item: dotAndLineView2, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -2.5)
        
        dotAndLineView3TopAnchor = dotAndLineView3.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 4)
        dotAndLineView3WidthAnchor = dotAndLineView3.widthAnchor.constraint(equalToConstant: dotWidth)
        dotAndLineView3HeightAnchor = dotAndLineView3.heightAnchor.constraint(equalToConstant: dotWidth)
        dotAndLineView3CenterXAnchor = NSLayoutConstraint(item: dotAndLineView3, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        
        dotAndLineView4TopAnchor = dotAndLineView4.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 4)
        dotAndLineView4WidthAnchor = dotAndLineView4.widthAnchor.constraint(equalToConstant: dotWidth)
        dotAndLineView4HeightAnchor = dotAndLineView4.heightAnchor.constraint(equalToConstant: dotWidth)
        dotAndLineView4CenterXAnchor = NSLayoutConstraint(item: dotAndLineView4, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 2.5)
        
        dotAndLineView5TopAnchor = dotAndLineView5.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 4)
        dotAndLineView5WidthAnchor = dotAndLineView5.widthAnchor.constraint(equalToConstant: dotWidth)
        dotAndLineView5HeightAnchor = dotAndLineView5.heightAnchor.constraint(equalToConstant: dotWidth)
        dotAndLineView5CenterXAnchor = NSLayoutConstraint(item: dotAndLineView5, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 6)
        
        dotAndLineView1WidthAnchor.identifier = "dotAndLineView1WidthAnchor"
        dotAndLineView1TopAnchor.identifier = "dotAndLineView1TopAnchor"
        dotAndLineView1HeightAnchor.identifier = "dotAndLineView1HeightAnchor"
        dotAndLineView1CenterXAnchor.identifier = "dotAndLineView1CenterXAnchor"
        
        dotAndLineView2WidthAnchor.identifier = "dotAndLineView2WidthAnchor"
        dotAndLineView2TopAnchor.identifier = "dotAndLineView2TopAnchor"
        dotAndLineView2HeightAnchor.identifier = "dotAndLineView2HeightAnchor"
        dotAndLineView2CenterXAnchor.identifier = "dotAndLineView2CenterXAnchor"
        
        dotAndLineView3WidthAnchor.identifier = "dotAndLineView3WidthAnchor"
        dotAndLineView3TopAnchor.identifier = "dotAndLineView3TopAnchor"
        dotAndLineView3HeightAnchor.identifier = "dotAndLineView3HeightAnchor"
        dotAndLineView3CenterXAnchor.identifier = "dotAndLineView3CenterXAnchor"
        
        dotAndLineView4WidthAnchor.identifier = "dotAndLineView4WidthAnchor"
        dotAndLineView4TopAnchor.identifier = "dotAndLineView4TopAnchor"
        dotAndLineView4HeightAnchor.identifier = "dotAndLineView4HeightAnchor"
        dotAndLineView4CenterXAnchor.identifier = "dotAndLineView4CenterXAnchor"
        
        dotAndLineView4WidthAnchor.identifier = "dotAndLineView4WidthAnchor"
        dotAndLineView4TopAnchor.identifier = "dotAndLineView4TopAnchor"
        dotAndLineView4HeightAnchor.identifier = "dotAndLineView4HeightAnchor"
        dotAndLineView4CenterXAnchor.identifier = "dotAndLineView4CenterXAnchor"
        
    }
    
    //일
    let lbl: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()
        label.textColor = Colors.darkGray
        label.layer.cornerRadius = label.frame.height / 2
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tag = 30
        return label
    }()
    
    let dotAndLineView1: UIView = {
        let dotView = UIView()
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.layer.masksToBounds = true
        dotView.clipsToBounds = true
        dotView.backgroundColor = UIColor(displayP3Red: 96 / 255, green: 118 / 255, blue: 221 / 255, alpha: 1.0)
        return dotView
    }()
    
    let dotAndLineView2: UIView = {
        let dotView = UIView()
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.layer.masksToBounds = true
        dotView.clipsToBounds = true
        dotView.backgroundColor = UIColor(displayP3Red: 7 / 255, green: 166 / 255, blue: 255 / 255, alpha: 1.0)
        return dotView
    }()
    
    let dotAndLineView3: UIView = {
        let dotView = UIView()
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.clipsToBounds = true
        dotView.backgroundColor = UIColor(displayP3Red: 254 / 255, green: 109 / 255, blue: 109 / 255, alpha: 1.0)
        return dotView
    }()
    
    let dotAndLineView4: UIView = {
        let dotView = UIView()
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.clipsToBounds = true
        dotView.backgroundColor = UIColor(displayP3Red: 255 / 255, green: 160 / 255, blue: 160 / 255, alpha: 1.0)
        return dotView
    }()
    
    let dotAndLineView5: UIView = {
        let dotView = UIView()
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.clipsToBounds = true
        dotView.backgroundColor = .black
        return dotView
    }()
    
    private lazy var dotWidth = self.frame.width * 0.11
    
    private lazy var lintHeight = self.frame.height * 0.08
    
    private lazy var lineWidth = self.frame.width

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawDotAndLineView(_ indexPath: IndexPath, eventDictionary:[Int: [event]] ) {
        
        guard let eventNum = eventDictionary[indexPath.row]?.count else {
            return
        }
        
        dotAndLineView1.isHidden = true
        dotAndLineView2.isHidden = true
        dotAndLineView3.isHidden = true
        dotAndLineView4.isHidden = true
        dotAndLineView5.isHidden = true
        
        if todoStatus == .todoShow {
            
            guard let events = eventDictionary[indexPath.row] else {
                return
            }
            
            var eventCategoryList: [Int] = []
            
            for event in events {
                eventCategoryList.append(event.categoryIdx)
            }
        
            switch eventNum {
            case 1:
                dotAndLineView1.isHidden = false
                
                dotAndLineView1TopAnchor.constant = 4
                dotAndLineView1WidthAnchor.constant = dotWidth
                dotAndLineView1HeightAnchor.constant = dotWidth
                dotAndLineView1CenterXAnchor.constant = 0
                
                NSLayoutConstraint.activate([
                    dotAndLineView1TopAnchor,
                    dotAndLineView1WidthAnchor,
                    dotAndLineView1HeightAnchor,
                    dotAndLineView1CenterXAnchor
                    ])
                
            case 2:
                dotAndLineView1.isHidden = false
                dotAndLineView2.isHidden = false
        
                dotAndLineView1TopAnchor.constant = 4
                dotAndLineView1WidthAnchor.constant = dotWidth
                dotAndLineView1HeightAnchor.constant = dotWidth
                dotAndLineView1CenterXAnchor = NSLayoutConstraint(item: dotAndLineView1, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -3)

                dotAndLineView2TopAnchor.constant = 4
                dotAndLineView2WidthAnchor.constant = dotWidth
                dotAndLineView2HeightAnchor.constant = dotWidth
                dotAndLineView2CenterXAnchor = NSLayoutConstraint(item: dotAndLineView2, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 3)
                
                NSLayoutConstraint.activate([
                    dotAndLineView1TopAnchor,
                    dotAndLineView1WidthAnchor,
                    dotAndLineView1HeightAnchor,
                    dotAndLineView1CenterXAnchor,
                    
                    dotAndLineView2TopAnchor,
                    dotAndLineView2WidthAnchor,
                    dotAndLineView2HeightAnchor,
                    dotAndLineView2CenterXAnchor
                    ])
                
            case 3:
                dotAndLineView1.isHidden = false
                dotAndLineView2.isHidden = false
                dotAndLineView3.isHidden = false
                
                dotAndLineView1TopAnchor.constant = 4
                dotAndLineView1WidthAnchor.constant = dotWidth
                dotAndLineView1HeightAnchor.constant = dotWidth
                dotAndLineView1CenterXAnchor = NSLayoutConstraint(item: dotAndLineView1, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -5)
                
                dotAndLineView2TopAnchor.constant = 4
                dotAndLineView2WidthAnchor.constant = dotWidth
                dotAndLineView2HeightAnchor.constant = dotWidth
                dotAndLineView2CenterXAnchor = NSLayoutConstraint(item: dotAndLineView2, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                dotAndLineView3TopAnchor.constant = 4
                dotAndLineView3WidthAnchor.constant = dotWidth
                dotAndLineView3HeightAnchor.constant = dotWidth
                dotAndLineView3CenterXAnchor = NSLayoutConstraint(item: dotAndLineView3, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 5)
                
                NSLayoutConstraint.activate([
                    dotAndLineView1TopAnchor,
                    dotAndLineView1WidthAnchor,
                    dotAndLineView1HeightAnchor,
                    dotAndLineView1CenterXAnchor,
                    
                    dotAndLineView2TopAnchor,
                    dotAndLineView2WidthAnchor,
                    dotAndLineView2HeightAnchor,
                    dotAndLineView2CenterXAnchor,
                    
                    dotAndLineView3TopAnchor,
                    dotAndLineView3WidthAnchor,
                    dotAndLineView3HeightAnchor,
                    dotAndLineView3CenterXAnchor
                    ])
                
            case 4:
                
                dotAndLineView1.isHidden = false
                dotAndLineView2.isHidden = false
                dotAndLineView3.isHidden = false
                dotAndLineView4.isHidden = false
                
                dotAndLineView1TopAnchor.constant = 4
                dotAndLineView1WidthAnchor.constant = dotWidth
                dotAndLineView1HeightAnchor.constant = dotWidth
                dotAndLineView1CenterXAnchor = NSLayoutConstraint(item: dotAndLineView1, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -5)
                
                dotAndLineView2TopAnchor.constant = 4
                dotAndLineView2WidthAnchor.constant = dotWidth
                dotAndLineView2HeightAnchor.constant = dotWidth
                dotAndLineView2CenterXAnchor = NSLayoutConstraint(item: dotAndLineView2, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -2)
                
                dotAndLineView3TopAnchor.constant = 4
                dotAndLineView3WidthAnchor.constant = dotWidth
                dotAndLineView3HeightAnchor.constant = dotWidth
                dotAndLineView3CenterXAnchor = NSLayoutConstraint(item: dotAndLineView3, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 2)
                
                dotAndLineView4TopAnchor.constant = 4
                dotAndLineView4WidthAnchor.constant = dotWidth
                dotAndLineView4HeightAnchor.constant = dotWidth
                dotAndLineView4CenterXAnchor = NSLayoutConstraint(item: dotAndLineView4, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 5)
                
                NSLayoutConstraint.activate([
                    dotAndLineView1TopAnchor,
                    dotAndLineView1WidthAnchor,
                    dotAndLineView1HeightAnchor,
                    dotAndLineView1CenterXAnchor,
                    
                    dotAndLineView2TopAnchor,
                    dotAndLineView2WidthAnchor,
                    dotAndLineView2HeightAnchor,
                    dotAndLineView2CenterXAnchor,
                    
                    dotAndLineView3TopAnchor,
                    dotAndLineView3WidthAnchor,
                    dotAndLineView3HeightAnchor,
                    dotAndLineView3CenterXAnchor,
                    
                    dotAndLineView4TopAnchor,
                    dotAndLineView4WidthAnchor,
                    dotAndLineView4HeightAnchor,
                    dotAndLineView4CenterXAnchor
                    ])
            
            case 5:
                
                dotAndLineView1.isHidden = false
                dotAndLineView2.isHidden = false
                dotAndLineView3.isHidden = false
                dotAndLineView4.isHidden = false
                dotAndLineView5.isHidden = false
                
                dotAndLineView1TopAnchor.constant = 4
                dotAndLineView1WidthAnchor.constant = dotWidth
                dotAndLineView1HeightAnchor.constant = dotWidth
                dotAndLineView1CenterXAnchor = NSLayoutConstraint(item: dotAndLineView1, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -6)
                
                
                dotAndLineView2TopAnchor.constant = 4
                dotAndLineView2WidthAnchor.constant = dotWidth
                dotAndLineView2HeightAnchor.constant = dotWidth
                dotAndLineView2CenterXAnchor = NSLayoutConstraint(item: dotAndLineView2, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: -2.5)
                
                dotAndLineView3TopAnchor.constant = 4
                dotAndLineView3WidthAnchor.constant = dotWidth
                dotAndLineView3HeightAnchor.constant = dotWidth
                dotAndLineView3CenterXAnchor = NSLayoutConstraint(item: dotAndLineView3, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                dotAndLineView4TopAnchor.constant = 4
                dotAndLineView4WidthAnchor.constant = dotWidth
                dotAndLineView4HeightAnchor.constant = dotWidth
                dotAndLineView4CenterXAnchor = NSLayoutConstraint(item: dotAndLineView4, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 2.5)
                
                dotAndLineView5TopAnchor.constant = 4
                dotAndLineView5WidthAnchor.constant = dotWidth
                dotAndLineView5HeightAnchor.constant = dotWidth
                dotAndLineView5CenterXAnchor = NSLayoutConstraint(item: dotAndLineView4, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 6)
                
                NSLayoutConstraint.activate([
                    dotAndLineView1TopAnchor,
                    dotAndLineView1WidthAnchor,
                    dotAndLineView1HeightAnchor,
                    dotAndLineView1CenterXAnchor,
                    
                    dotAndLineView2TopAnchor,
                    dotAndLineView2WidthAnchor,
                    dotAndLineView2HeightAnchor,
                    dotAndLineView2CenterXAnchor,
                    
                    dotAndLineView3TopAnchor,
                    dotAndLineView3WidthAnchor,
                    dotAndLineView3HeightAnchor,
                    dotAndLineView3CenterXAnchor,
                    
                    dotAndLineView4TopAnchor,
                    dotAndLineView4WidthAnchor,
                    dotAndLineView4HeightAnchor,
                    dotAndLineView4CenterXAnchor,
                    
                    dotAndLineView5TopAnchor,
                    dotAndLineView5WidthAnchor,
                    dotAndLineView5HeightAnchor,
                    dotAndLineView5CenterXAnchor
                    ])
            
            default:
                break
            }
            
        } else {
            switch eventNum {
            case 1:
                
        
                dotAndLineView1TopAnchor.constant = 4
                dotAndLineView1WidthAnchor.constant = lineWidth
                dotAndLineView1HeightAnchor.constant = lintHeight
                dotAndLineView1CenterXAnchor = NSLayoutConstraint(item: dotAndLineView1, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                NSLayoutConstraint.activate([
                    dotAndLineView1TopAnchor,
                    dotAndLineView1WidthAnchor,
                    dotAndLineView1HeightAnchor,
                    dotAndLineView1CenterXAnchor
                    ])
                
                
                
                dotAndLineView1.isHidden = false
        
            case 2:
                
                dotAndLineView1.isHidden = false
                dotAndLineView2.isHidden = false
                
                dotAndLineView1TopAnchor.constant = 4
                dotAndLineView1WidthAnchor.constant = lineWidth
                dotAndLineView1HeightAnchor.constant = lintHeight
                dotAndLineView1CenterXAnchor = NSLayoutConstraint(item: dotAndLineView1, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                dotAndLineView2TopAnchor.constant = 2.5
                dotAndLineView2WidthAnchor.constant = lineWidth
                dotAndLineView2HeightAnchor.constant = lintHeight
                dotAndLineView2CenterXAnchor = NSLayoutConstraint(item: dotAndLineView2, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                NSLayoutConstraint.activate([
                    dotAndLineView1TopAnchor,
                    dotAndLineView1WidthAnchor,
                    dotAndLineView1HeightAnchor,
                    dotAndLineView1CenterXAnchor,
                    
                    dotAndLineView2TopAnchor,
                    dotAndLineView2WidthAnchor,
                    dotAndLineView2HeightAnchor,
                    dotAndLineView2CenterXAnchor
                    ])
                
            case 3:
                
                dotAndLineView1.isHidden = false
                dotAndLineView2.isHidden = false
                dotAndLineView3.isHidden = false
                
                dotAndLineView1TopAnchor.constant = 4
                dotAndLineView1WidthAnchor.constant = lineWidth
                dotAndLineView1HeightAnchor.constant = lintHeight
                dotAndLineView1CenterXAnchor = NSLayoutConstraint(item: dotAndLineView1, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                dotAndLineView2TopAnchor.constant = 2.5
                dotAndLineView2WidthAnchor.constant = lineWidth
                dotAndLineView2HeightAnchor.constant = lintHeight
                dotAndLineView2CenterXAnchor = NSLayoutConstraint(item: dotAndLineView2, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                dotAndLineView3TopAnchor.constant = 2.5
                dotAndLineView3WidthAnchor.constant = lineWidth
                dotAndLineView3HeightAnchor.constant = lintHeight
                dotAndLineView3CenterXAnchor = NSLayoutConstraint(item: dotAndLineView3, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 5)
                
                NSLayoutConstraint.activate([
                    dotAndLineView1TopAnchor,
                    dotAndLineView1WidthAnchor,
                    dotAndLineView1HeightAnchor,
                    dotAndLineView1CenterXAnchor,
                    
                    dotAndLineView2TopAnchor,
                    dotAndLineView2WidthAnchor,
                    dotAndLineView2HeightAnchor,
                    dotAndLineView2CenterXAnchor,
                    
                    dotAndLineView3TopAnchor,
                    dotAndLineView3WidthAnchor,
                    dotAndLineView3HeightAnchor,
                    dotAndLineView3CenterXAnchor
                    ])
                
            case 4:
                dotAndLineView1.isHidden = false
                dotAndLineView2.isHidden = false
                dotAndLineView3.isHidden = false
                dotAndLineView4.isHidden = false
                
                dotAndLineView1TopAnchor.constant = 4
                dotAndLineView1WidthAnchor.constant = lineWidth
                dotAndLineView1HeightAnchor.constant = lintHeight
                dotAndLineView1CenterXAnchor = NSLayoutConstraint(item: dotAndLineView1, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                dotAndLineView2TopAnchor.constant = 4
                dotAndLineView2WidthAnchor.constant = lineWidth
                dotAndLineView2HeightAnchor.constant = lintHeight
                dotAndLineView2CenterXAnchor = NSLayoutConstraint(item: dotAndLineView2, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                dotAndLineView3TopAnchor.constant = 4
                dotAndLineView3WidthAnchor.constant = lineWidth
                dotAndLineView3HeightAnchor.constant = lintHeight
                dotAndLineView3CenterXAnchor = NSLayoutConstraint(item: dotAndLineView3, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                dotAndLineView4TopAnchor.constant = 4
                dotAndLineView4WidthAnchor.constant = lineWidth
                dotAndLineView4HeightAnchor.constant = lintHeight
                dotAndLineView4CenterXAnchor = NSLayoutConstraint(item: dotAndLineView4, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                NSLayoutConstraint.activate([
                    dotAndLineView1TopAnchor,
                    dotAndLineView1WidthAnchor,
                    dotAndLineView1HeightAnchor,
                    dotAndLineView1CenterXAnchor,
                    
                    dotAndLineView2TopAnchor,
                    dotAndLineView2WidthAnchor,
                    dotAndLineView2HeightAnchor,
                    dotAndLineView2CenterXAnchor,
                    
                    dotAndLineView3TopAnchor,
                    dotAndLineView3WidthAnchor,
                    dotAndLineView3HeightAnchor,
                    dotAndLineView3CenterXAnchor,
                    
                    dotAndLineView4TopAnchor,
                    dotAndLineView4WidthAnchor,
                    dotAndLineView4HeightAnchor,
                    dotAndLineView4CenterXAnchor
                    ])
                
            case 5:
                dotAndLineView1.isHidden = false
                dotAndLineView2.isHidden = false
                dotAndLineView3.isHidden = false
                dotAndLineView4.isHidden = false
                dotAndLineView5.isHidden = false
                
                dotAndLineView1TopAnchor.constant = 4
                dotAndLineView1WidthAnchor.constant = lineWidth
                dotAndLineView1HeightAnchor.constant = lintHeight
                dotAndLineView1CenterXAnchor = NSLayoutConstraint(item: dotAndLineView1, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                
                dotAndLineView2TopAnchor.constant = 4
                dotAndLineView2WidthAnchor.constant = lineWidth
                dotAndLineView2HeightAnchor.constant = lintHeight
                dotAndLineView2CenterXAnchor = NSLayoutConstraint(item: dotAndLineView2, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                dotAndLineView3TopAnchor.constant = 4
                dotAndLineView3WidthAnchor.constant = lineWidth
                dotAndLineView3HeightAnchor.constant = lintHeight
                dotAndLineView3CenterXAnchor = NSLayoutConstraint(item: dotAndLineView3, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                dotAndLineView4TopAnchor.constant = 4
                dotAndLineView4WidthAnchor.constant = lineWidth
                dotAndLineView4HeightAnchor.constant = lintHeight
                dotAndLineView4CenterXAnchor = NSLayoutConstraint(item: dotAndLineView4, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                dotAndLineView5TopAnchor.constant = 4
                dotAndLineView5WidthAnchor.constant = lineWidth
                dotAndLineView5HeightAnchor.constant = lintHeight
                dotAndLineView5CenterXAnchor = NSLayoutConstraint(item: dotAndLineView5, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
                
                NSLayoutConstraint.activate([
                    dotAndLineView1TopAnchor,
                    dotAndLineView1WidthAnchor,
                    dotAndLineView1HeightAnchor,
                    dotAndLineView1CenterXAnchor,
                    
                    dotAndLineView2TopAnchor,
                    dotAndLineView2WidthAnchor,
                    dotAndLineView2HeightAnchor,
                    dotAndLineView2CenterXAnchor,
                    
                    dotAndLineView3TopAnchor,
                    dotAndLineView3WidthAnchor,
                    dotAndLineView3HeightAnchor,
                    dotAndLineView3CenterXAnchor,
                    
                    dotAndLineView4TopAnchor,
                    dotAndLineView4WidthAnchor,
                    dotAndLineView4HeightAnchor,
                    dotAndLineView4CenterXAnchor,
                    
                    dotAndLineView5TopAnchor,
                    dotAndLineView5WidthAnchor,
                    dotAndLineView5HeightAnchor,
                    dotAndLineView5CenterXAnchor
                    ])
            default:
                break
            }

        }
    }
}

extension NSLayoutConstraint {
    override open var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
