/*
 * Compile with:
 * javac Honeybees.java
 * Run with:
 * java Honeybees
 * */

class Pot {
	private int m_capacity;
	private int m_honey;
	private boolean m_full;
	public Pot(int capacity) {
		m_capacity = capacity;
		m_honey = 0;
		m_full = false;
	}
	
	public synchronized void putHoney() {
		if (!m_full) {
			++m_honey;
			System.out.println("Bee added some honey. pot is now " + m_honey + " of " + m_capacity);
			if (m_honey == m_capacity) {
				System.out.println("Bee woke up bear.");
				m_full = true;
				notify();
			}
		}
		while (m_full) {
			/* Wait for the bear to eat the honey. */
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
	
	public synchronized void eat() {
		System.out.println("Bear ate honey");
		m_honey = 0;
		m_full = false;
		notifyAll();
	}

	public synchronized void waitForHoney() {
		System.out.println("Bear is asleep");
		while (!m_full) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}

class Bee extends Thread {
	private Pot m_pot;
	private int m_id;
	private boolean m_bkilled;
	public Bee(int id, Pot pot) {
		m_pot = pot;
		m_id = id;
		m_bkilled = false;
	}
	public void run() {
		for (;!m_bkilled;) {
			try {
				sleep((int)(Math.random()*100));
			} catch (InterruptedException e) {
				System.out.println("Bee is " + m_id + " dead");
				return;
			}
			if (m_bkilled)
				break;
			m_pot.putHoney();
		}
	}
	public void kill() {
		m_bkilled = true;
	}
}

class Bear extends Thread {
	private Pot m_pot;
	private Bee m_bees[];
	private int m_turnsLeft;
	public Bear(int nbees, int turns) {
		m_pot = new Pot(10);
		m_turnsLeft = turns;
		m_bees = new Bee[nbees];
		for (int i = 0; i < nbees; ++i) {
			m_bees[i] = new Bee(i, m_pot);
			m_bees[i].start();
		}
	}
	
	public void run() {
		while (m_turnsLeft-- != 0) {
			m_pot.waitForHoney();
			m_pot.eat();
		}
		
		System.out.println("Bear is killing the bees");
		for (int i = 0; i < m_bees.length; ++i) {
			m_bees[i].kill();
		}
		for (int i = 0; i < m_bees.length; ++i) {
			try {
				m_bees[i].join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("All bees are dead");
	}
}

public class Honeybees {
	public static void main(String[] args) {
		Bear b = new Bear(5, 10);
		b.start();
		try {
			b.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("Bear is dead");
	}
}
