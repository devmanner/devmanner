/*
 * Created on Mar 8, 2003
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code and Comments
 */
package TentaPlugg;

import java.io.File;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.*;
import org.xml.sax.SAXException;

/**
 * @author tomas
 */
public class BasicDOM {
	public static void main(String[] args) {
		Document doc = parseXmlFile("file.xml");
		if (doc == null) {
			System.out.println("Något fel...");
		} else {
			xmlPrint(doc);
			/*
			NodeList list = doc.getElementsByTagName("addressentries");
			System.out.println(list.toString() + " " + list.getLength());
			for (int i = 0; i < list.getLength(); ++i) {
				if (list.item(i) instanceof Element) {
					Element element = (Element) list.item(i);
					NodeList children = element.getChildNodes();
					for (int j = 0; j < children.getLength(); ++j) {
						if (children.item(j) instanceof Element) {
							Element childElem = (Element) children.item(j);
							Node textNode = childElem.getFirstChild();
							String s = textNode.getNodeValue().trim();
							System.out.println("Tag: " + childElem.getTagName() + " -> Value:" + s);
						}
						else if (children.item(j) instanceof Node) {
							String s = children.item(j).getNodeValue().trim();
							System.out.println("Tag: " + " -> Value:" + s);							
						}
						else {
							System.out.println("Not a Element (child)");								
						}
					}
				}
				else {
					System.out.println("Not a Element");	
				}				
			}
			*/
		}
		//System.out.println(doc);
	}

	public static void xmlPrint(Document doc) {
		NodeList list = doc.getChildNodes();
		recXmlPrint(list);
	}

	private static void recXmlPrint(NodeList list) {
		System.out.println("Start");
		for (int i = 0; i < list.getLength(); ++i) {
			if (list.item(i).hasChildNodes()) {
				recXmlPrint(list.item(i).getChildNodes());
			} else {
				for (int j = 0; j < list.getLength(); ++j) {
					System.out.println(list.item(j).getClass().toString());
					System.out.println(list.item(j).getNodeName() + " -> " + list.item(j).getNodeValue() ); 		
				}
			}
		}
	}
	
	public static Document parseXmlFile(String fname) {
		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			Document doc = factory.newDocumentBuilder().parse(new File(fname));
			return doc;
		} catch (SAXException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		}
		return null;		
	}
}

