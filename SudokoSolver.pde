import java.util.ArrayList;
import java.util.List;

int DIM = 9;

int[][] grid = new int[DIM][DIM];

int xPos = 0;
int yPos = 0;

color backcol = color(255);

boolean end = false;

void setup() {
    size(450,450);
    String[] lines = loadStrings("puzzle.txt");
    for (int i = 0; i < DIM; i++) {
        for (int j = 0; j < DIM; j++) {
            grid[j][i] = Integer.parseInt(lines[i].split("")[j]);
        }
    }
}

int findPos(int n) {
    int val;
    switch(n) {
        case 0:
            val = 1;
            break;
        case 1:
            val = 4;
            break;
        case 2:
            val = 7;
            break;
        default :
        val = -1;
        break;
    }
    return val;
}

void solve(int x, int y) {
    int val = grid[x][y];
    int[] options = new int[DIM];
    for (int i = 0; i < DIM; i++) {
        options[i] = 1;
    }
    for (int i = 0; i < DIM; i++) {
        //column: grid[x][i]
        if (grid[x][i] > 0) {
            options[grid[x][i] - 1] = 0;
        }
        //row grid[i][y]
        if (grid[i][y] > 0) {
            options[grid[i][y] - 1] = 0;
        }
    }
    int gridX = findPos(ceil(x / 3));
    int gridY = findPos(ceil(y / 3));
    //square:
    for (int i = -1; i < 2;i++) {
        for (int j = -1; j < 2;j++) {
            if (i ==  0 && j ==  0) {
                continue;
            }
            if (grid[gridX + i][gridY + j] > 0) {
                options[grid[gridX + i][gridY + j] - 1] = 0;
            }
        }
    }
    int optLen = 0;
    int output = 0;
    for (int i = 0; i < DIM; i++) {
        if (options[i] > 0) {
            optLen++;
            if (optLen > 1) {
                break;
            }
            output = i + 1;
        }
    }
    if (optLen == 1) {
        grid[x][y] = output;
    }
    // println(options);
}

boolean check() {
    println("Checking:");
    String[] solution = loadStrings("solution.txt");
    for (int i = 0; i < DIM; i++) {
        for (int j = 0; j < DIM; j++) {
            if (grid[j][i] != Integer.parseInt(solution[i].split("")[j]))
                return false;
        }
    }
    println("Check Successful!");
    return true;
}

void draw() {
    background(backcol);
    int w = width / DIM;
    int h = height / DIM;
    textSize(w * 0.75);
    textAlign(CENTER, CENTER);
    fill(0);
    stroke(0);
    boolean solved = true;
    // text("H", w/2, w/2);
    for (int i = 0; i < DIM; i++) {
        for (int j = 0; j < DIM; j++) {
            strokeWeight(2);
            if (j ==  0 && i!= 0) {
                if (i % 3 == 0) {
                    strokeWeight(4);
                }
                line(i * w, 0, i * w, height);
            }
            if (i ==  0 && j!= 0) {
                if (j % 3 == 0) {
                    strokeWeight(4);
                }
                line(0, j * h, width, j * h);
            }
            int cellX = i * w;
            cellX += w / 2;
            int cellY = j * h;
            cellY += h / 2;

            if (grid[i][j] > 0) text(grid[i][j], cellX, cellY);
            else{
                solved = false;
            }
        }
    }
    if (end) {
        noLoop();

    }
    if (!solved) {
        if (grid[xPos][yPos]  == 0)
            solve(xPos, yPos);
        xPos++;
        if (xPos > 8) {
            xPos = 0;
            yPos++;
        }
        if (yPos > 8) {
            yPos = 0;
        }
    } else if (solved && !end) {
        if (check()) {
            backcol = color(0,128,0);
            println("Solved!");
            end = true;
        }
        else{
            backcol = color(128,0,0);
            println("Not solved.");
            end = true;
        }

    }

}
