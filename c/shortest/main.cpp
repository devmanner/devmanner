#include <fstream.h>

void Weight(char *, char *);
int Find(char *, char );

main () {
        char matrix[] = {'1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', 's', '1', '0', '1', '0', '1', '0', '1', '0', '0', '0', '0', '1', '1', '0', '1', '0', '1', '0', '1', '0', '1', '0', '1', '0', '0', '1', '1', '0', '0', '0', '0', '0', '1', '0', '1', '0', '1', '0', '0', '1', '1', '1', '1', '1', '1', '0', '1', '0', '1', '0', '1', '0', '0', '1', '1', '0', '0', '1', '0', '0', '1', '0', '1', '0', '1', '0', '0', '1', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0', 'f', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1'};
        char *weight = new char[112];
        Weight(matrix, weight);
        return 0;
}

void Weight(char *maze, char *result) {
        int start = Find(maze, 's');
        int finish = Find(maze, 's');
        cout << start << " " << finish << endl;
}

int Find(char *matrix, char what) {
        for (int i = 0; i < 112; i++)
                if (matrix[i] == what)
                        return i;
        return -1;
}

