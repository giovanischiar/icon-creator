//
//  Platform.swift
//
//
//  Created by Giovani Schiar on 14/12/22.
//

enum Platform {
	case android
	case ios
}

extension String {
	var platform: Platform { self == "ios" ? .ios : .android }
}
