//
//  Helper.swift
//  WBooks
//
//  Created by leonardo.a.simoza on 2/11/21.
//

import UIKit

class Helper {
    static func loadDummy(completation: ((Result<Books, Error>) -> Void)? = nil) {
        guard let dummy = Bundle.main.url(forResource: "MockLibrary", withExtension: "json"), let dummyData = try? Data(contentsOf: dummy) else { return }
        if let data = try? JSONDecoder().decode(Books.self, from: dummyData) {
            completation!(.success(data))
        } else {
            print("JsonDecoder Model Error")
        }
    }
    
    static func sizeBy(width: CGFloat? = 0, height: CGFloat? = 0) -> (screenWidth: CGFloat, screenHeight: CGFloat) {
        let baseDeviceWidth: CGFloat = Constants.DeviceBase.width
        let baseDeviceHeight: CGFloat = Constants.DeviceBase.height
        let deviceWidth: CGFloat = UIScreen.main.bounds.size.width
        let sizeWidth: CGFloat = (deviceWidth * ((width ?? 0) / baseDeviceWidth))
        let deviceHeight: CGFloat = UIScreen.main.bounds.size.height
        let sizeHeight: CGFloat = (deviceHeight * ((height ?? 0) / baseDeviceHeight))
        return (sizeWidth, sizeHeight)
    }
}
