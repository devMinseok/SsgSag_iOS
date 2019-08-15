//
//  MyPageServiceProtocol.swift
//  SsgSag
//
//  Created by 이혜주 on 27/07/2019.
//  Copyright © 2019 wndzlf. All rights reserved.
//

import Foundation

protocol MyPageService: class {
    
    func requestSelectedState(
        completionHandler: @escaping ((DataResponse<Interests>) -> Void)
    )
    
    func requestStoreSelectedField(
        _ selectedIndex: [Int],
        completionHandler: @escaping ((DataResponse<HttpStatusCode>) -> Void)
    )
    
    func requestStoreAddActivity(
        _ jsonData: [String: Any],
        completionHandler: @escaping ((DataResponse<Activity>) -> Void)
    )
    
    func reqeuestStoreJobsState(
        _ selectedJson: [String: Any],
        completionHandler: @escaping ((DataResponse<ReInterest>) -> Void)
    )
    
    func requestEditActivity(
        _ jsonData: [String: Any],
        completionHandler: @escaping ((DataResponse<Activity>) -> Void)
    )
    
    func requestUserInformation(
        completionHandler: @escaping (DataResponse<UserNetworkModel>) -> Void
    )
    
    func requestMembershipCancel(
        completionHandler: @escaping (DataResponse<HttpStatusCode>) -> Void
    )
    
    func requestChangePassword(
        oldPassword: String,
        newPassword: String,
        completionHandler: @escaping (DataResponse<HttpStatusCode>) -> Void
    )
    
    func requestUpdateUserInfo(
        bodyData: [String: Any],
        completionHandler: @escaping (DataResponse<HttpStatusCode>) -> Void
    )
    
    func requestUpdateProfile(
        boundary: String,
        bodyData: Data,
        completionHandler: @escaping (DataResponse<HttpStatusCode>) -> Void
    )
    
}
