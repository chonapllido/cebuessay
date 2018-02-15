package stm.com.sys;

import java.io.File;

import javax.servlet.ServletContext;

import org.apache.commons.lang3.StringUtils;

import stm.com.support.util.ApplicationHelper;
import egovframework.rte.fdl.property.EgovPropertyService;

public class Configs {

	public static boolean IS_REAL_SERVER = false;

	public static String DEV_IP = "";
	public static String DOMAIN = "";
	public static String CHARSET = "";
	public static String CONTEXT = "";
	public static String CONTEXT_WEB = "";
	public static String IMG_SRC = "";
	public static String CSS_SRC = "";
	public static String JS_SRC = "";
	public static String FORMAT_DATE = "";
	public static String FORMAT_DATEE = "";
	public static String FORMAT_DATETIME = "";
	public static String FORMAT_DATEETIME = "";
	public static String FORMAT_TIME = "";
	public static String FORMAT_TIMEE = "";
	public static String SUPER_ADMIN_ID = "";
	public static int PAGE_UNIT = 0;
	public static int PAGE_SIZE = 0;
	public static int NEW_DAY = 0;

	public static String ROOT_PATH = "";
	public static String WWW_PATH = "";
	public static String SAVE_PATH = "";
	public static String UI_PATH = "";
	public static String TEMP_PATH = "";
	public static String DOC_PATH = "";
	public static String CONTENT_PATH = "";

	public Configs(ServletContext context) {
		EgovPropertyService service = (EgovPropertyService) ApplicationHelper.getService("propertiesService", context);
		IS_REAL_SERVER = service.getBoolean("is_real_server");
		DEV_IP = service.getString("dev_ip");
		DOMAIN = IS_REAL_SERVER ? service.getString("domain") : "test" + service.getString("domain");
		CHARSET = service.getString("charset");
		CONTEXT = IS_REAL_SERVER ? service.getString("context") : "";
		CONTEXT_WEB = IS_REAL_SERVER ? service.getString("context_web") : "";
		IMG_SRC = service.getString("img_src");
		CSS_SRC = service.getString("css_src");
		JS_SRC = service.getString("js_src");
		FORMAT_DATE = service.getString("format_date");
		FORMAT_DATEE = service.getString("format_datee");
		FORMAT_DATETIME = service.getString("format_datetime");
		FORMAT_DATEETIME = service.getString("format_dateetime");
		FORMAT_TIME = service.getString("format_time");
		FORMAT_TIMEE = service.getString("format_timee");
		SUPER_ADMIN_ID = service.getString("super_admin_id");
		PAGE_UNIT = service.getInt("page_unit");
		PAGE_SIZE = service.getInt("page_size");
		NEW_DAY = service.getInt("new_day");
		WWW_PATH = service.getString("www_path");
		SAVE_PATH = service.getString("save_path");
		UI_PATH = service.getString("ui_path");
		TEMP_PATH = service.getString("temp_path");
		DOC_PATH = service.getString("doc_path");
		CONTENT_PATH = service.getString("content_path");

		// 업로드 경로 생성
		ROOT_PATH = StringUtils.isEmpty(ROOT_PATH) ? context.getRealPath("") : ROOT_PATH;
		File file = new File(ROOT_PATH);
		if (!file.exists()) {
			file.mkdir();
		}
		WWW_PATH = context.getRealPath("") + WWW_PATH;
		file = new File(WWW_PATH);
		if (!file.exists()) {
			file.mkdir();
		}
		SAVE_PATH = context.getRealPath("") + SAVE_PATH;
		file = new File(SAVE_PATH);
		if (!file.exists()) {
			file.mkdir();
		}
		UI_PATH = context.getRealPath("") + UI_PATH;
		file = new File(UI_PATH);
		if (!file.exists()) {
			file.mkdir();
		}
		TEMP_PATH = context.getRealPath("") + TEMP_PATH;
		file = new File(TEMP_PATH);
		if (!file.exists()) {
			file.mkdir();
		}
		DOC_PATH = context.getRealPath("") + DOC_PATH;
		file = new File(DOC_PATH);
		if (!file.exists()) {
			file.mkdir();
		}
		CONTENT_PATH = context.getRealPath("") + CONTENT_PATH;
		file = new File(CONTENT_PATH);
		if (!file.exists()) {
			file.mkdir();
		}

		context.setAttribute(Constants.CONFIGS, this);
	}

	public final boolean isIS_REAL_SERVER() {
		return IS_REAL_SERVER;
	}

	public final String getDEV_IP() {
		return DEV_IP;
	}

	public final String getDOMAIN() {
		return DOMAIN;
	}

	public final String getCHARSET() {
		return CHARSET;
	}

	public final String getCONTEXT() {
		return CONTEXT;
	}

	public final String getCONTEXT_WEB() {
		return CONTEXT_WEB;
	}

	public final String getIMG_SRC() {
		return IMG_SRC;
	}

	public final String getCSS_SRC() {
		return CSS_SRC;
	}

	public final String getJS_SRC() {
		return JS_SRC;
	}

	public final String getFORMAT_DATE() {
		return FORMAT_DATE;
	}

	public final String getFORMAT_DATEE() {
		return FORMAT_DATEE;
	}

	public final String getFORMAT_DATETIME() {
		return FORMAT_DATETIME;
	}

	public final String getFORMAT_DATEETIME() {
		return FORMAT_DATEETIME;
	}

	public final String getFORMAT_TIME() {
		return FORMAT_TIME;
	}

	public final String getFORMAT_TIMEE() {
		return FORMAT_TIMEE;
	}

	public final String getSUPER_ADMIN_ID() {
		return SUPER_ADMIN_ID;
	}

	public final int getPAGE_UNIT() {
		return PAGE_UNIT;
	}

	public final int getPAGE_SIZE() {
		return PAGE_SIZE;
	}

	public final int getNEW_DAY() {
		return NEW_DAY;
	}

	public final String getROOT_PATH() {
		return ROOT_PATH;
	}

	public final String getWWW_PATH() {
		return WWW_PATH;
	}

	public final String getSAVE_PATH() {
		return SAVE_PATH;
	}

	public final String getUI_PATH() {
		return UI_PATH;
	}

	public final String getTEMP_PATH() {
		return TEMP_PATH;
	}

	public final String getDOC_PATH() {
		return DOC_PATH;
	}

	public final String getCONTENT_PATH() {
		return CONTENT_PATH;
	}
}
