//
//  CapitalDetail.swift
//  module_43
//
//  Created by Denis Loctier on 07/02/2023.
//

import Foundation
import SwiftUI

struct CapitalDetail: View {
    var capital: Capital
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                Image(capital.image)
                    .resizable()
                    .frame(height: 300)
                
                Text(capital.info)
                    .padding()
            }
            .navigationBarTitle(Text(capital.name))
        }
    }
}
