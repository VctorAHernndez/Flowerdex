//
//  StatusIcons.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/2/20.
//

import SwiftUI

struct StatusIcon: View {
    var sysName: String
    var statusText: String
    var body: some View {
        VStack {
            Image(systemName: sysName)
                .font(.system(size: 40))
            Text(statusText)
                .font(.headline)
                .padding(.vertical)
        }
        .foregroundColor(Constants.Colors.blueGray)
    }
}

struct NoMatchIcon: View {
    var body: some View {
        StatusIcon(sysName: "zzz", statusText: "No matching results")
    }
}

struct FailureIcon: View {
    var body: some View {
        StatusIcon(sysName: "xmark", statusText: "Something went wrong... 😔")
    }
}

struct StatusIcons_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoMatchIcon()
            FailureIcon()
        }
    }
}
