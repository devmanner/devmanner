/*
 * Created on Mar 9, 2003
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code and Comments
 */
package TentaPlugg;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.helpers.DefaultHandler;
import org.xml.sax.Attributes;

/**
 * @author tomas
 */

public class BasicSAX {
	public static void main(String[] args) throws Exception {
		DefaultHandler handler = new DefaultHandler() {
			private boolean enable; 
			public void startElement(String namespaceURI, String lname, String qname, Attributes attrs){
				System.out.println("start: " + lname + " " + qname);				
				enable = (lname.compareToIgnoreCase("FirstName") == 0);
			}
			public void characters(char[] data, int start, int length) {
				if (enable)
					System.out.println("Got: " + new String(data, start, length));
			}
			public void endElement(String namespaceURI, String lname, String qname) {
				System.out.println("end: " + lname + " " + qname);				
				if (lname.compareToIgnoreCase("Address") == 0)
					enable = false;
				System.out.println("Enable: "+ enable);				
			}
			
		};
		
		SAXParserFactory factory = SAXParserFactory.newInstance();
		factory.setNamespaceAware(true);
		SAXParser parser = factory.newSAXParser();
		InputStream in = new FileInputStream(new File("file.xml"));
		parser.parse(in, handler);
		
	}
}
