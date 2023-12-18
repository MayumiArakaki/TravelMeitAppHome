//
//  HomeViewBuilder.swift
//  Home
//
//  Created by Enrique Alata Vences on 14/12/23.
//

import UIKit

public class HomeViewBuilder {
    
    public static func getFirstView() -> UIViewController? {
        let moduleBundle = Bundle(for: HomeViewBuilder.self)
        guard let homeViewController = UIStoryboard.init(name: "Home", bundle: moduleBundle).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return nil}
        return homeViewController
    }
}
