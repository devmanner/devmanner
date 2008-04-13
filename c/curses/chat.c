#include <panel.h>
int main() {
    WINDOW *output;
    WINDOW *input;
    PANEL *output_pan;
    PANEL *input_pan;
    char s[80];
    int ch;

    initscr();
    cbreak();
    noecho();
    
    output = newwin(10, 60, 0, 0);
    input = newwin(2, 60, 10, 0);

    box(output, 0, 0);
    box(input, 0, 0);

    input_pan = new_panel(input);
    output_pan = new_panel(output);
 
    update_panels();
    doupdate();
    
    getstr(s);
    while((ch = getch()) != KEY_F(1)) {
	
    }


    getch();
    endwin();

    printf("String: %s\n", s);
}
