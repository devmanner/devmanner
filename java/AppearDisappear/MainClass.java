import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class MainClass {
	public static void main(String[] args) {
		MyFrame frame = new MyFrame("Appear Disappear");
		frame.show();
	}
}

class MyFrame extends JFrame {
	private JTextField text = new JTextField("Click me");
	private JButton button = new JButton("Reappear");
	private JPanel panel = new JPanel();
	public MyFrame(String s) {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setName(s);
		setSize(200,200);
		
		button.addMouseListener(new MouseAdapter(){
			public void mousePressed(MouseEvent e) {
				text.setVisible(true);	
			}
		});
		
		text.addFocusListener(new FocusAdapter(){
			public void focusGained(FocusEvent e) {
				text.setVisible(false);	
				System.out.println("BALLE");	
			}	
		});
		
		panel.add(text);
		panel.add(button);
		
		getContentPane().add(panel);
	}	
}
