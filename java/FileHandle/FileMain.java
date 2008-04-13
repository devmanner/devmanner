import java.io.*;

public class FileMain {
	public static void main(String[] args) {
		try {
			String fileName = "/home/tomas/foo.txt";
			File fp = new File(fileName);
			if (!fp.exists()) {
				System.out.println("Filen finns inte!");
				fp.createNewFile();
			}
			double d = 0;
			RandomAccessFile file = new RandomAccessFile(fileName, "rw");
			for (int i = 0; i < 10 ; i++, d++)
				file.writeDouble(d);
				
			file.close();
			
			file = new RandomAccessFile(fileName, "r");
			for (int i = 0; i < 5; i++) {
				file.seek(8*i*2);
				d = file.readDouble();
				System.out.println(d);
			}
				
		} catch (IOException ex) {
			System.out.println(ex.getMessage());
		}
		
			
	}
}
