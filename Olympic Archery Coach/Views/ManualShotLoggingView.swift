import SwiftUI

struct ManualShotLoggingView: View {
  @StateObject private var session = Session()
  @State private var selectedScore = 10
  @State private var selectedDirection: Direction = .topRight

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Score")) {
          Stepper("\(selectedScore)", value: $selectedScore, in: 1...10)
        }
        Section(header: Text("Direction")) {
          Picker("Direction", selection: $selectedDirection) {
            ForEach(Direction.allCases) { dir in
              Text(dir.rawValue).tag(dir)
            }
          }
          .pickerStyle(.segmented)
        }
        Button("Log Shot") {
          let shot = Shot(
            timestamp: Date(),
            score: selectedScore,
            direction: selectedDirection
          )
          session.shots.append(shot)
        }
        .frame(maxWidth: .infinity, alignment: .center)
      }
      .navigationTitle("Log a Shot")
      .toolbar {
        ToolbarItem(placement: .bottomBar) {
          Text("Total shots: \(session.shots.count)")
        }
      }
    }
  }
}

struct ManualShotLoggingView_Previews: PreviewProvider {
  static var previews: some View {
    ManualShotLoggingView()
  }
}
