package stm.com.sys;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ContextListener implements ServletContextListener {

	private final Logger logger = LoggerFactory.getLogger(getClass());
	private ServletContext context;

	public synchronized void contextInitialized(ServletContextEvent contextEvent) {
		logger.debug("			:: Context Initialized [start]");

		context = contextEvent.getServletContext();

		// System Initialized
		try {
			new SysInitialized(context);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		logger.debug("			:: Context Initialized [finish]");
	}

	public synchronized void contextDestroyed(ServletContextEvent contextEvent) {
		context = contextEvent.getServletContext();
		logger.debug("			:: Context Destroyed");
	}
}
