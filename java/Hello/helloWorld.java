import java.awt.*;
import javax.swing.*;

public class HelloWorld {
    public static void main(String [] args) {
	JFrame frame = new JFrame("My program");
	frame.getContentPane().add(new JLabel("Hello world!", Label.CENTER));
	frame.show();
	system.exit();
    }
}
