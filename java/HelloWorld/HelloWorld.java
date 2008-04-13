/**
 * @author tomas
 *
 * To change this generated comment edit the template variable "typecomment":
 * Window>Preferences>Java>Templates.
 */
import javax.swing.*;

public class HelloWorld {
	public static void main(String[] args) {
		JFrame frame = new JFrame("Hello World");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setSize(100,100);
		frame.getContentPane().add(new JLabel("Hello world"));
		frame.show();	
	}
}
