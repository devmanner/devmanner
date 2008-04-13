import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Busigt {
	public static void main(String[] args) {
		BusFrame frame = new BusFrame("An error has occured on your computer");
		frame.show();		
	}
}

class BusFrame extends JFrame {
	private JLabel label1 = new JLabel("An error has occured on your computer.");
	private JLabel label2 = new JLabel("Possible cause is that you have a small penis.");
	private JLabel label3 = new JLabel("Do you have a small penis?");
	
	private JButton no1 = new JButton("No");
	private JButton no2 = new JButton("No");
	private JButton yes = new JButton("Yes");
	private JPanel panel = new JPanel();
	
	public BusFrame(String n) {
		setName(n);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setSize(300, 200);
		no1.setVisible(false);
		
		no1.addMouseListener(new MouseAdapter(){
			public void mouseEntered(MouseEvent e) {
				no2.setVisible(true);
				no1.setVisible(false);
			}
		});

		no2.addMouseListener(new MouseAdapter(){
			public void mouseEntered(MouseEvent e) {
				no1.setVisible(true);
				no2.setVisible(false);
			}
		});
		
		yes.addMouseListener(new MouseAdapter() {
			public void mousePressed(MouseEvent e) {
				System.exit(0);
			}
		});

		panel.add(label1);
		panel.add(label2);
		panel.add(label3);
		panel.add(no1);
		panel.add(yes);
		panel.add(no2);
		getContentPane().add(panel);
				
	}	
}