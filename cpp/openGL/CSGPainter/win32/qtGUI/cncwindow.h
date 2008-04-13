#ifndef _CNCWINDOW_H_
#define _CNCWINDOW_H_

#include <string>
#include <fstream>
#include <qtextview.h>
#include <qmessagebox.h>

#include "../cncparser.h"

class CNCWindow : public QTextView {
	Q_OBJECT        // must include this if you use Qt signals/slots

private:
	CNCParser *m_pParser;
	std::vector<std::string> m_file;
	void update() {
		int crow = m_pParser->getCurrentRow();
		std::string out;
		for(int i=0; i < m_file.size(); ++i){
			out += ((i == crow) ? std::string("> ") : std::string("  ")) + m_file[i] + "\n";
		}
		setText(out.c_str());
		printf("CNCWIndow, current line is: %d\n", m_pParser->getCurrentRow());
	}
public:
	CNCWindow(std::string fname, CNCParser *parser) : QTextView(), m_pParser(parser) {
		readFile(fname);
	}
	void notify() {
		update();
	}
	void readFile(std::string fname) {
		try {
			char buf[80];
			if(strcmp(fname.c_str(), "") == 0)
				throw FileNotFoundException(fname);

			std::string line;
			m_file.clear();
			
			std::ifstream source(fname.c_str());
			if(!source)
				throw FileNotFoundException(fname);
			
			while (source.getline(buf, 80))
				m_file.push_back(std::string(buf));
			
#ifdef _DEBUG_MODE_
	printf("CNCWindow::readFile(%s) reading...\n", fname.c_str());		
#endif
		}
		catch (FileNotFoundException fnfe) {
			QMessageBox error("File not found", fnfe.getMessage().c_str(), QMessageBox::Critical, 
			QMessageBox::Ok, QMessageBox::NoButton, QMessageBox::NoButton, this, "File not found", true );
			printf("%s\n", fnfe.getMessage().c_str());
		}

	}
};


#endif

 