//
//  ServiceInfoViewController.swift
//  SsgSag
//
//  Created by admin on 13/05/2019.
//  Copyright © 2019 wndzlf. All rights reserved.
//

import UIKit

class ServiceInfoViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ServiceInfoTableViewCell.self, forCellReuseIdentifier: ServiceInfoViewController.cellId)
        return tableView
    }()
    
    static private let numberOfRows = 4
    
    static private let cellId = "cellId"
    
    private var Info:[String] = ["앱 정보" ,
                                 "이용약관",
                                 "개인정보 보호정책",
                                 "Open Source License"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    @IBAction func dissMiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension ServiceInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ServiceInfoViewController.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let serviceInfoCell = tableView.dequeueReusableCell(withIdentifier: ServiceInfoViewController.cellId)
            as? ServiceInfoTableViewCell else { return UITableViewCell() }
        
        serviceInfoCell.selectionStyle = .none
        serviceInfoCell.cellInfo = Info[indexPath.row]
        
        return serviceInfoCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let notiCase = NotificationInfo(rawValue: indexPath.row) else {return}
        
        let storyboard = UIStoryboard(name: StoryBoardName.mypage, bundle: nil)
        
        switch notiCase {
        case .notification:
            
            guard let appInfoVC = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.appInfoViewController) as? AppInfoViewController else {return}
            
            self.navigationController?.pushViewController(appInfoVC, animated: true)
        
        // FIXME: - privateProtect와 termnsOfService의 이름이 바뀌었습니다.
        case .privateProtect:
            
            guard let termsOfServiceViewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.termsOfServiceViewController) as? TermsOfServiceViewController else {return}
            
            self.navigationController?.pushViewController(termsOfServiceViewController, animated: true)
        case .termsOfService:
    
            guard let privateProtectViewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.privateProtectViewController) as? PrivateProtectViewController else {return}
            
            self.navigationController?.pushViewController(privateProtectViewController, animated: true)
            break
        case .openSourceLicense:
            break
        }
    }
    
}

enum NotificationInfo: Int {
    case notification = 0
    case termsOfService = 1
    case privateProtect = 2
    case openSourceLicense = 3
}