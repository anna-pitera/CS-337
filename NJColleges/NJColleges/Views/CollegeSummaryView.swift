//
//  SummaryView.swift
//  NJColleges
//
//  Created by Anna R. Pitera on 10/21/26.
//

import SwiftUI

struct CollegeSummaryView: View {
    @State var collegeVM = CollegeViewModel()
    var totalColleges: Int { collegeVM.njColleges.count }

    var northColleges: Int {
        collegeVM.njColleges.filter { $0.latitude > 40.47368 }.count
    }
    var southColleges: Int {
        collegeVM.njColleges.filter { $0.latitude < 39.95219 }.count
    }
    var centralColleges: Int {
        collegeVM.njColleges.filter {
            $0.latitude > 39.95219 && $0.latitude <= 40.47378
        }.count
    }

    var body: some View {
        Image("jersey")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 500, height: 500, alignment: .center)
            .border(.black)
        
        
        VStack(alignment: .center, spacing: 10) {
            Text("NJ Colleges")
                .font(.title)
                .bold()

            HStack(alignment: .center) {
                Label("Total Colleges:", systemImage: "book")
                    .bold()
                Spacer()
                Text(String(totalColleges))
            }
            
            HStack(alignment: .center) {
                Label("North Jersey Colleges:", systemImage: "arrow.up")
                    .foregroundStyle(.yellow)
                    .bold()
                Spacer()
                Text(String(northColleges))
            }
            
            HStack(alignment: .center) {
                Label("Central Jersey Colleges:", systemImage: "arrow.down.and.line.horizontal.and.arrow.up")
                    .foregroundStyle(.orange)
                    .bold()
                Spacer()
                Text(String(centralColleges))
            }
            
            HStack(alignment: .center) {
                Label("South Jersey Colleges:", systemImage: "arrow.down")
                    .foregroundStyle(.red)
                    .bold()
                Spacer()
                Text(String(southColleges))
            }
        }
        .padding()
    }

}

#Preview {
    CollegeSummaryView()
}
