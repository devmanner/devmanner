
/*
 * Created on Feb 11, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 * @author manner
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

class PrinterHandler {
	public static final int A = 0;
	public static final int B = 1;
	public static final int ANY = 2;

	private int m_npend[];
	private int m_occupied[];
	
	public PrinterHandler() {
		m_npend = new int[2];
		m_npend[A] = m_npend[B] = 0;
		m_occupied = new int[2];
		m_occupied[A] = m_occupied[B] = 0;
	}
	
	private void print(int printer, String job) {
		System.out.println("printer: " + (printer == A ? "A" : "B") + " prints: " + job);
	}
	/* Return the printer the job got to (used to select printer if printer == ANY) */
	private synchronized int startRequestPrint(int printer) {
		/* If ANY select printer with shortest queue */
		if (printer == ANY)
			printer = (m_npend[A] < m_npend[B]) ? A : B;
		
		m_npend[printer]++;
		while (m_occupied[printer] == 1) {
			System.out.println(m_npend[printer] + " waiting for printer: " + (printer == A ? "A" : "B"));
			try {
				wait();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		m_occupied[printer] = 1;
		m_npend[printer]--;
		return printer;
	}
	private synchronized void endRequestPrint(int printer) {
		m_occupied[printer] = 0;
		notify();
	}
	
	public void requestPrint(int printer, String job) {
		printer = startRequestPrint(printer);
		print(printer, job);
		endRequestPrint(printer);
	}
}

class Job extends Thread {
	private PrinterHandler m_handler;
	private int m_id;
	
	public Job(PrinterHandler handler, int id) {
		m_id = id;
		m_handler = handler;
	}
	public void run() {
		for (int i = 0; i < 10; ++i) {
			int printer = (int)(Math.random() * 3);
			String str = "Job " + m_id + " requests job on: ";
			if (printer == PrinterHandler.ANY)
				str += "ANY";
			else if (printer == PrinterHandler.A)
				str += "A";
			else if (printer == PrinterHandler.B)
				str += "B";
			System.out.println(str);
			
			
			m_handler.requestPrint(printer, new String("Job from printer: " + m_id));
			try {
				sleep((int)(Math.random() * 10));
			} catch (InterruptedException e) {
				return;
			}
		}
	}
}

public class Printer {

	public static void main(String[] args) {
		final int njobs = 10;
		PrinterHandler handler = new PrinterHandler();
		Job jobs[] = new Job[njobs];
		for (int i = 0; i < njobs; ++i) {
			jobs[i] = new Job(handler, i);
			jobs[i].start();
		}
	}
}
