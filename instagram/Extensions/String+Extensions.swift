//
//  String+Extensions.swift
//  instagram
//
//  Created by 张杰 on 2020/12/17.
//

import Foundation

extension String {
    func safaDatabaseKey() -> String {
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}
