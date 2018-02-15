package stm.com.sys;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SysInitialized {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	public SysInitialized(ServletContext context) throws Exception {

		logger.debug("		:: System Initializing... ");

		// System Code
		new Configs(context);
		new Codes(context);

		// Tag Libraries
		String[] components = { "paging1", "button", "abutton" };
		if (components.length > 0) {
			Map<String, StringBuffer> map = new HashMap<String, StringBuffer>();
			for (int i = 0; i < components.length; i++) {
				try {
					BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream(new File(Configs.UI_PATH + System.getProperty("file.separator") + components[i] + ".html")), Configs.CHARSET));
					String s;
					StringBuffer html = new StringBuffer();

					int j = 0;
					while ((s = in.readLine()) != null) {
						if (j == 0) {
							logger.debug("		:: Found STM Standard Components for Tag Library #" + i + " : " + components[i] + ".html");
						}
						html.append(s + "\n");
						j++;
					}
					in.close();

					if (!StringUtils.isEmpty(html.toString())) {
						map.put(components[i], html);
					}
				} catch (IOException e) {
					logger.error("		:: Not Found STM Standard Components for Tag Library #" + i + " : " + components[i] + ".html");
				}
			}
			if (map.size() > 0) {
				context.setAttribute(Constants.TLDS, map);
			}
		}
	}
}
