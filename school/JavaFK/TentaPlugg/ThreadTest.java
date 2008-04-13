/*
 * Created on Mar 8, 2003
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code and Comments
 */
package TentaPlugg;

import java.util.LinkedList;
import java.util.StringTokenizer;

/**
 * @author tomas
 */

public class ThreadTest {
	public static void main(String args[]) {
		LinkedList l = new LinkedList();
		//l = (LinkedList)Collections.synchronizedList(l);
		AdderThread a = new AdderThread(l);
		DeleterThread b = new DeleterThread(l);
		try {
			a.join();
			b.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("All is dead.");	
	}
}

class AdderThread extends Thread {
	private String m_s;
	private LinkedList m_l;
	public AdderThread(LinkedList l){
		m_l = l;
		start();	
	}
	public void run() {
		StringTokenizer st = new StringTokenizer("a b c d e f g h i j k l  m n o p");
		for(int i = 0; i < 10; ++i) {
			String s = st.nextToken();
			System.out.println("Next token: " + s);
			m_l.add(s);
			try {
				sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}

class DeleterThread extends Thread {
	private LinkedList m_l;
	public DeleterThread(LinkedList l){
		m_l = l;
		start();	
	}
	public void run() {
		for(int i = 0; i < 10; ++i) {
			if (m_l.size() > 0)
				System.out.println((String)m_l.removeFirst());
			try {
				sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}
