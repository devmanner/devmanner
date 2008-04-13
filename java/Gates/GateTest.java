
public class GateTest {
	public static void main(String[] args) {
		Gate g1 = new AndGate(4);
		System.out.println("And gate truth table 4 inputs");
		g1.printTable();

		Gate g2 = new OrGate();
		System.out.println("Or gate truth table 2 inputs");
		g2.printTable();
	}
}

abstract class Gate {
	protected boolean [] ports;
	public int getNumberOfInputs() {
		return ports.length;
	}
	public void setInput(int port, boolean value) {
		ports[port] = value;
	}
	public void printInputs() {
		for (int i = 0; i < ports.length; i++)
			System.out.print(ports[i] + " ");
	}
	public abstract boolean giveOutput();
	public void printTable() {
		for (int i = 0; i < java.lang.Math.pow(2, getNumberOfInputs()); i++) {
			int value = i;
			for (int port = getNumberOfInputs() -1; port >= 0; port --) {
				if ((value%2) == 0)
					setInput(port, false);
				else
					setInput(port, true);
				value /= 2;
			}
			printInputs();
			System.out.print(" => ");
			System.out.println(giveOutput());
		}
	}	
	
	public Gate (int n) {
		ports = new boolean[n];
	}
}

class AndGate extends Gate{
	public boolean giveOutput() {
		for (int i = 0; i < ports.length; i++)
			if (!ports[i])
				return false;
		return true;
	}
	public AndGate(int n) {
		super(n);
	}	
	public AndGate() {
		super(2);
	}
}

class OrGate extends Gate{
	public boolean giveOutput() {
		for (int i = 0; i < ports.length; i++)
			if (ports[i])
				return true;
		return false;
	}
	public OrGate(int n) {
		super(n);
	}	
	public OrGate() {
		super(2);
	}	
}
