/*
 * Compile with:
 * javac Water.java
 * Run with:
 * java Water
 * */


class WaterCreator {
	public static final int FREE = 0;
	public static final int READY = 1;
	public static final int CONSUMED = 2;
	
	private int m_hready[];
	private int m_hcnt; // Number of arrived H atoms
	private int m_hdone; // index of first unconsumed H atom
	private int m_ncreated;
	
	public WaterCreator(int no) {
		m_hready = new int[no*2];
		m_ncreated = m_hdone = m_hcnt = 0;
	}
	public synchronized void oReady() {		
		int hindex = m_hdone; // Pick two H-atoms to wait for.
		m_hdone += 2;
		System.out.println("An O is waiting for H: " + hindex + " and " + (hindex+1));
		notifyAll();
		
		while (m_hready[hindex] == FREE) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		while (m_hready[hindex+1] == FREE) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		makeWater(hindex);
	}
	public synchronized void hReady() {
		int hindex = m_hcnt; // Get who I am.
		m_hcnt++;
		m_hready[hindex] = READY;
		notifyAll();
		
		while (m_hready[hindex] == READY) {
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
	private synchronized void makeWater(int hindex) {
		m_hready[hindex] = CONSUMED;
		m_hready[hindex+1] = CONSUMED;
		notifyAll();
		++m_ncreated;
		System.out.println("Made water molecule number: " + m_ncreated);
	}
}

class O extends Thread {
	private WaterCreator m_creator;
	public O(WaterCreator w) {
		m_creator = w;
	}
	public void run() {
		try {
			sleep((int)(Math.random()*10));
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("An O atom is ready");
		m_creator.oReady();
		System.out.println("An O atom was consumed.");
	}
}

class H extends Thread {
	private WaterCreator m_creator;
	public H(WaterCreator w) {
		m_creator = w;
	}
	public void run() {
		try {
			sleep((int)(Math.random()*10000));
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("A H atom is ready");
		m_creator.hReady();
		System.out.println("A H atom was consumed.");
	}
}

public class Water {
	public static void main(String[] args) {
		final int nO = 200;
		WaterCreator creator = new WaterCreator(nO);
		O o[] = new O[nO];
		H h[] = new H[nO*2];
		for (int i = 0; i < nO; ++i) {
			o[i] = new O(creator);
			o[i].start();
		}
		for (int i = 0; i < nO*2; ++i) {
			h[i] = new H(creator);
			h[i].start();
		}
		
		for (int i = 0; i < nO; ++i) {
			try {
				o[i].join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		for (int i = 0; i < nO*2; ++i) {
			try {
				h[i].join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("All H and O atoms consumed.");
	}
}
