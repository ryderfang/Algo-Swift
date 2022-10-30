//
//  ObjExt.swift
//  AlgoBase
//
//  Created by Ryder on 2022/10/30.
//

import Foundation

public extension NSObject {
    static func getObjectAddress(object: AnyObject) -> String {
        let str = Unmanaged<AnyObject>.passUnretained(object).toOpaque()
        return String(describing: str)
    }

    static func getObjectIdentifier(object: AnyObject) -> ObjectIdentifier {
        return ObjectIdentifier(object)
    }
}
