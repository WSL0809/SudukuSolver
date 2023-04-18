class SudokuSolver {
    var grid: [[Int]]
    
    
    init(grid: [[Int]]) {
        self.grid = grid
    }
    
    func solve() -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                // 查找空单元格
                if grid[row][col] == 0 {
                    // 尝试填入数字
                    for num in 1...9 {
                        if isValid(row: row, col: col, num: num) {
                            grid[row][col] = num
                            
                            // 递归求解剩余的单元格
                            if solve() {
                                return true
                            }
                            
                            // 如果无法找到解决方案，重置单元格
                            grid[row][col] = 0
                        }
                    }
                    
                    // 如果无法填入任何数字，返回false
                    return false
                }
            }
        }
        
        // 如果所有单元格都已填满，返回true
        return true
    }
    
    func isValid(row: Int, col: Int, num: Int) -> Bool {
        // 检查行
        for c in 0..<9 {
            if grid[row][c] == num {
                return false
            }
        }
        
        // 检查列
        for r in 0..<9 {
            if grid[r][col] == num {
                return false
            }
        }
        
        // 检查小九宫格
        let boxRow = row - row % 3
        let boxCol = col - col % 3
        
        for r in boxRow..<(boxRow + 3) {
            for c in boxCol..<(boxCol + 3) {
                if grid[r][c] == num {
                    return false
                }
            }
        }
        
        // 如果通过了所有检查，返回true
        return true
    }
}
