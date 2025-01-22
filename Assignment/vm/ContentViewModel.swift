//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData? = nil
    var data: [DeviceData]? = []

    func fetchAPI(callback: @escaping (String) -> Void) {
        apiService.fetchDeviceDetails(completion: { item in
            self.data = item
            // intentianally added empty callback
            callback("")
        })
    }
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}
