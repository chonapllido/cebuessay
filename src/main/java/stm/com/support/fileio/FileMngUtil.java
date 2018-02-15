package stm.com.support.fileio;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovBasicLogger;
import egovframework.com.cmm.util.EgovResourceCloseHelper;

public class FileMngUtil {
	
	public static final int BUFF_SIZE = 2048;
	
	public HashMap<String, String> parseFileInf(Map<String, MultipartFile> files, String folderDest) throws Exception {

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		String filePath = EgovProperties.getProperty("Globals.orderFilesPath") + folderDest;
		HashMap<String, String> result = new HashMap<String, String>();

		String originFileNameList = "";
		String newFileNameList = "";

		int idx = 1;
	
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
	
			file = entry.getValue();
			String originFileName = file.getOriginalFilename();
			
			int index = originFileName.lastIndexOf(".");
			String fileExt = originFileName.substring(index + 1);
			
			DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
			Date date = new Date();
			String mydate = dateFormat.format(date);
			
			if ("".equals(originFileName)) {
				continue;
			}
			
			String newFileName = mydate + "_" + idx + "." + fileExt;

			if (!"".equals(originFileName)) {

				file.transferTo(new File(filePath + newFileName));
				
				if(!"".equals(originFileNameList)){
					originFileName = ":" + originFileName;
				}
				if(!"".equals(newFileNameList)){
					newFileName = ":" + newFileName;
				}
			}

			originFileNameList += originFileName;
			newFileNameList += newFileName;
			
			idx++;
			
		}
		result.put("newFileNameList", newFileNameList);
		result.put("originFileNameList", originFileNameList);

		return result;
		
	}
	
	public HashMap<String, String> parseFileOrigNm(Map<String, MultipartFile> files, String folderDest) throws Exception {

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		String filePath = EgovProperties.getProperty("Globals.orderFilesPath") + folderDest;
		HashMap<String, String> result = new HashMap<String, String>();

		String originFileNameList = "";

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
	
			file = entry.getValue();
			String originFileName = file.getOriginalFilename();

			if ("".equals(originFileName)) {
				continue;
			}
			if (!"".equals(originFileName)) {

				file.transferTo(new File(filePath + originFileName));
				
				if(!"".equals(originFileNameList)){
					originFileName = ":" + originFileName;
				}
			}
			originFileNameList += originFileName;
		}
		result.put("originFileNameList", originFileNameList);

		return result;
	}
	
	public FileCommand uploadFile(Map<String, MultipartFile> files, String folderDest) throws Exception {

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		String filePath = EgovProperties.getProperty("Globals.orderFilesPath") + folderDest;
	
		FileCommand _cmd = new FileCommand();
		String originFileNameList = "";
		String fileTypeList = "";

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
	
			file = entry.getValue();
			String originFileName = file.getOriginalFilename();
			String fileType = FilenameUtils.getExtension(originFileName);

			if ("".equals(originFileName)) {
				continue;
			}
			if (!"".equals(originFileName)) {

				file.transferTo(new File(filePath + originFileName));
				
				if(!"".equals(originFileNameList)){
					originFileName = ":" + originFileName;
					fileType = ":" + fileType;
				}
			}
			originFileNameList += originFileName;
			fileTypeList += fileType;
		}
		
		_cmd.setOrig_name(originFileNameList);
		_cmd.setType(fileTypeList);
	
		return _cmd;
		
	}
	
	public HashMap<String, String> parseFileInfSingle(MultipartFile file, String folderDest) throws Exception {

		String filePath = EgovProperties.getProperty("Globals.orderFilesPath") + folderDest;
		HashMap<String, String> result = new HashMap<String, String>();

		String originFileNameList = "";
		String newFileNameList = "";

		String originFileName = file.getOriginalFilename();
		
		int index = originFileName.lastIndexOf(".");
		String fileExt = originFileName.substring(index + 1);
		
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmss");
		Date date = new Date();
		String mydate = dateFormat.format(date);
		
		String newFileName = mydate + "." + fileExt;

		if (!"".equals(originFileName)) {
			file.transferTo(new File(filePath + originFileName));
		}

		originFileNameList += originFileName;
		newFileNameList += newFileName;
		
		result.put("newFileNameList", newFileNameList);
		result.put("originFileNameList", originFileNameList);

		return result;
		
	}
	public void createFile(String content, String folderDest, String fileName) throws IOException{
		
		String filePath = EgovProperties.getProperty("Globals.orderFilesPath") + folderDest;
		Writer out = new OutputStreamWriter(new FileOutputStream(filePath+fileName), "UTF-8");
		try{
			File cFile = new File(filePath);

			if (!cFile.isDirectory()) {
				boolean _flag = cFile.mkdir();
				if (!_flag) {
					throw new IOException("Directory creation Failed ");
				}
			}
			out.write(content);
		} finally{
			out.close();
		}
	}
	
	public void editFile(String content, String folderDest, String fileName) throws Exception{
		
		String filePath = EgovProperties.getProperty("Globals.orderFilesPath") + folderDest + fileName;
		FileWriter writer = null;
		try{
			writer = new FileWriter(filePath);
			writer.write(content);
		} catch(IOException e){
			e.printStackTrace();
		} finally{
			writer.close();
		}
	}
	
	public void downloadFile(FileCommand cmd, String folderDest, HttpServletRequest req, HttpServletResponse res) throws Exception {

		String filePath = EgovProperties.getProperty("Globals.orderFilesPath") + folderDest;
		File file = new File(filePath + cmd.getNew_name());

		if (!file.exists()) {
			throw new FileNotFoundException(filePath + cmd.getNew_name());
		}

		if (!file.isFile()) {
			throw new FileNotFoundException(filePath + cmd.getNew_name());
		}

		int fSize = (int) file.length();
		if (fSize > 0) {
			BufferedInputStream in = null;

			try {
				in = new BufferedInputStream(new FileInputStream(file));

				String mimetype = "application/x-msdownload";
				res.setContentType(mimetype);
				res.setHeader("Content-Disposition:", "attachment; filename=\"" + cmd.getOrig_name()+"\"");
				FileCopyUtils.copy(in, res.getOutputStream());
			} finally {
				EgovResourceCloseHelper.close(in);
			}
			res.getOutputStream().flush();
			res.getOutputStream().close();
		}
	}
	
	
}
