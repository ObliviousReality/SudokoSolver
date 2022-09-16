
int DIM = 9;

int[][] grid = new int[DIM][DIM];

void setup() {
    size(450,450);
    for (int i = 0; i < DIM; i++) {
        for (int j = 0; j < DIM; j++) {
            grid[i][j] = i;
        }
    }
}

void draw() {
    background(0);
    int w = width / DIM;
    int h = height / DIM;
    textSize(w * 0.75);
    textAlign(CENTER, CENTER);
    fill(255);
    stroke(255);
    // text("H", w/2, w/2);
    for (int i = 0; i < DIM; i++) {
        for (int j = 0; j < DIM; j++) {
            strokeWeight(2);
            if (j == 0 && i!= 0) {
                if (i % 3 == 0) {
                    strokeWeight(4);
                }
                line(i * w, 0, i * w, height);
            }
            if (i == 0 && j!= 0) {
                if (j % 3 == 0) {
                    strokeWeight(4);
                }
                line(0, j * h, width, j * h);
            }
            int cellX = i * w;
            cellX += w / 2;
            int cellY = j * h;
            cellY += h / 2;
            text(grid[i][j], cellX, cellY);

        }
    }
}
