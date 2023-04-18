import SwiftUI
struct SudokuView: View {
    @State var grid = [
        [0, 4, 0, 0, 0, 0, 0, 0, 5],
        [2, 0, 0, 0, 3, 0, 7, 0, 1],
        [3, 0, 5, 0, 1, 4, 0, 0, 0],
        [0, 7, 0, 1, 6, 0, 0, 0, 0],
        [0, 0, 0, 3, 5, 0, 0, 0, 2],
        [8, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 8, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 9, 0, 0, 0, 1, 0, 0],
        [0, 0, 3, 0, 8, 7, 0, 2, 0]
    ]
    @State var selectedCell: (row: Int, col: Int)? = nil
    
    var body: some View {
        VStack {
            ForEach(0..<9) { row in
                HStack {
                    ForEach(0..<9) { col in
                        let isHighlighted = selectedCell?.row == row && selectedCell?.col == col
                        let textBinding = Binding<String>(get: {
                            String(grid[row][col])
                        }, set: { newValue in
                            if let intValue = Int(newValue) {
                                grid[row][col] = intValue
                            }
                        })
                        TextField("", text: textBinding)
                            .font(.system(size: 24, weight: .semibold, design: .default))
                            .multilineTextAlignment(.center)
                            .frame(width: 30, height: 30)
                            .background(isHighlighted ? Color.yellow : Color.white)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .onTapGesture {
                                selectedCell = (row, col)
                            }
                            .background(
                                Group {
                                    if selectedCell?.row == row && selectedCell?.col == col {
                                        Text("")
                                            .font(.system(size: 24, weight: .semibold, design: .default))
                                            .multilineTextAlignment(.center)
                                            .frame(width: 30, height: 30)
                                            .background(Color.white)
                                            .cornerRadius(5)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color.black, lineWidth: 1)
                                            )
                                    }
                                }
                            )
                    }
                }
            }
            
            Button(action: solveSudoku) {
                Text("Solve")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
        }
        .padding()
    }
    
    func solveSudoku() {
        let solver = SudokuSolver(grid: grid)
        if solver.solve() {
            grid = solver.grid
        }
    }
}

struct SudokuView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuView()
    }
}


struct ContentView: View {
    var body: some View {
        SudokuView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
