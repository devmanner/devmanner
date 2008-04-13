/**
 * @author Tomas Mannerstedt
 */
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.*;

public class Bookmaker {
	public static void main(String[] args) {
		TipFrame frame = new TipFrame("TipMaster");
		frame.show();
	}
}

class TipFrame extends JFrame {
	JTextField in = new JTextField();
	JTextField type = new JTextField();
	JLabel typeLabel = new JLabel("Enter Type");
	JButton ok = new JButton("Generate rows");
	JLabel label = new JLabel("Enter number of rows:");
	JTextArea out = new JTextArea();
	JScrollPane scroller = new JScrollPane(out);
	JPanel northPanel = new JPanel();
	JPanel middlePanel = new JPanel();
	JPanel southPanel = new JPanel();

	public TipFrame(String name) {
		setName(name);
		setSize(400, 600);
		getContentPane().setLayout(new BorderLayout());
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		// The ok button
		ok.addMouseListener(new MouseAdapter(){
			public void mousePressed(MouseEvent e) {
				String outString = "";
				if (Integer.parseInt(in.getText()) > 0 && Integer.parseInt(in.getText()) < 101) {
					Row [] rows = new Row[Integer.parseInt(in.getText())];
					for (int i = 0; i < Integer.parseInt(in.getText()); i ++)
						rows[i] = RowFactory.getInstance().createRow(type.getText());
					for (int i = 0; i < Integer.parseInt(in.getText()); i ++)
						outString += rows[i].toString();
					out.setText(outString);
				}
				else {
					out.setText("Maximum number if rows is 100, minimum is 1.");	
				}
			}			
		});
		
		// The input fields
		in.setColumns(5);
		type.setColumns(2);
		
		// The output and the scroller
		out.setRows(30);
		out.setColumns(30);
		
		// Add everything
		northPanel.add(label);
		northPanel.add(in);

		middlePanel.add(typeLabel);
		middlePanel.add(type);
		middlePanel.add(ok);
		
		southPanel.add(scroller);
		
		getContentPane().add(northPanel, BorderLayout.NORTH);
		getContentPane().add(middlePanel);
		getContentPane().add(southPanel, BorderLayout.SOUTH);
	}	
}

class RowFactory {
	private static RowFactory fact;
	private RowFactory(){}
	public static RowFactory getInstance(){
		return (fact == null) ? fact = new RowFactory() : fact;
	}
	public Row createRow(String type) {
		Row r;
		if (type.equals("l"))
			r = new LottoRow();
		else if (type.equals("s"))
			r = new StryktipsRow();
		else
			r = new LottoRow();
		return r;
	}
}

abstract class Row {
	protected int[] row;
	abstract public String toString();
	abstract public boolean equals(Row r);
}


class LottoRow extends Row {
	public String toString(){
		return (new String(row[0] + "\n" + row[1] + "\n" + row[2] + "\n" + row[3] + "\n" + row[4] + "\n" + row[5] + "\n" + row[6] + "\n\n"));
	}
	public boolean equals(Row r){return false;}
	public LottoRow(){
		row = new int[7];
		for (int i = 0; i < row.length; i ++)
			row[i] = (int)(Math.random() * 33 +1);
		Arrays.sort(row);
	}
}

class StryktipsRow extends Row {
	public String toString(){
		String r = "";
		for (int i = 0; i < row.length; i ++)
			r += (row[i] == 2) ? "  X\n" : (row[i] == 3) ? "    2\n" : "1\n";
		r += "\n";
		return r;
	}
	public boolean equals(Row r){return false;}
	public StryktipsRow(){
		row = new int[13];
		for (int i = 0; i < row.length; i ++)
			row[i] = (int)(Math.random() * 3 +1);
	}
}