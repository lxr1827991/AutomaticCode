package com.lxr.acode;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.MissingFormatArgumentException;
import java.util.Properties;
import java.util.Set;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.beetl.core.Configuration;
import org.beetl.core.GroupTemplate;
import org.beetl.core.Template;
import org.beetl.core.resource.ClasspathResourceLoader;
import org.beetl.core.resource.StringTemplateResourceLoader;

/**
 * 
 * @author lxr
 *
 */
public class Main {

	static Context context = null;
	
	
	
	private void init() throws IOException {
		Properties properties = new Properties();
		
		properties.load(Main.class.getClassLoader().getResourceAsStream("ACode.properties"));
		
	   
         
	        Map<String, String> map = new HashMap<String, String>((Map) properties);    
	  
	        Set<Entry<String, String>> propertySet = map.entrySet();  
	        for (Object o : propertySet) {  
	            Map.Entry entry = (Map.Entry) o;  
	            
	        } 
		context = new Context();
		
		context.setConfig(map);

	}
	public static void main(String[] args) throws IOException {
		
		Main main = new Main();
		main.init();
		
		String basePath = context.getPropertie("basePath");
		
		Map<String, Object> map = new HashMap<String, Object>();
		String enclass = "com.foxtail.model.server.Complaint";
		String enname  = enclass.substring(enclass.lastIndexOf(".")+1);
		
		String daoPkg = "com.foxtail.dao.mybatis.server";
		String daoclass = daoPkg+"."+enname+"Dao";
		String daoname  = daoclass.substring(daoclass.lastIndexOf(".")+1);
		
		String serPkg = "com.foxtail.service.server";
		String serclass = serPkg+"."+enname+"Service";
		String sername = serclass.substring(serclass.lastIndexOf(".")+1);
		
		
		map.put("basePath", basePath);
		
		map.put("enClass", enclass);
		map.put("enName",new TlBean(enname));
		
		map.put("daoPkg", daoPkg);
		map.put("daoClass", daoclass);
		map.put("daoName", new TlBean(daoname));
		
		map.put("serPkg", serPkg);
		map.put("serClass", serclass);
		map.put("serName", new TlBean(sername));
		
		
		String mppath = "com\\foxtail\\mapping\\server\\"+new TlBean(enname).toLowerCaseFirst()+"_mapper.xml";
		String tbname = "ro_complaint";
		
		map.put("mpPath", mppath);
		map.put("tbName", tbname);
		
		
		String ctlPkg = "com.foxtail.controller.server";
		String ctlClass = ctlPkg+"."+enname+"Controller";
		String ctlName  = ctlClass.substring(ctlClass.lastIndexOf(".")+1);
		map.put("ctlPkg", ctlPkg);
		map.put("ctlClass", ctlClass);
		map.put("ctlName", new TlBean(ctlName));
		
		//main.crateController(map);
		main.templateMapperFile(map);
		//main.crateDao(map);
		//main.createService(map);
		System.out.println("ok");
	}
	

	public void crateController(Map<String, Object> map) throws IOException {
		Map<String, Object> param = new HashMap<String, Object>();
		param.putAll(map);
		
		String outPath = class2FilePath(param.get("ctlClass").toString(),param.get("basePath").toString());
		
		File f = new File(outPath);
		if(!f.exists()){f.getParentFile().mkdirs();f.createNewFile();}
			
		
		output(param, new InputStreamReader(getClass().getResourceAsStream("/template/Controller.java.tl"))
				, new FileWriter(outPath));

	}
	
	
	public void crateDao(Map<String, Object> map) throws IOException {
		Map<String, Object> param = new HashMap<String, Object>();
		param.putAll(map);
		
		String outPath = class2FilePath(param.get("daoClass").toString(),param.get("basePath").toString());
		
		File f = new File(outPath);
		if(!f.exists()){f.getParentFile().mkdirs();f.createNewFile();}
			
		
		output(param, new InputStreamReader(getClass().getResourceAsStream("/template/MenberDao.java.tl"))
				, new FileWriter(outPath));

	}
	
	private void createService(Map<String, Object> map) throws IOException {
		Map<String, Object> param = new HashMap<String, Object>();
		param.putAll(map);
		
		String outPath = class2FilePath(param.get("serClass").toString(),param.get("basePath").toString());
		
		File f = new File(outPath);
		if(!f.exists()){f.getParentFile().mkdirs();f.createNewFile();}
			
		
		output(param, new InputStreamReader(getClass().getResourceAsStream("/template/MenberService.java.tl"))
				, new FileWriter(outPath));

	}
	
	
	public void templateMapperFile(Map<String, Object> map) throws IOException {
	
		Map<String, Object> param = new HashMap<String, Object>();
		param.putAll(map);
		
		String outPath =param.get("basePath").toString()+"\\"+param.get("mpPath").toString();
		
		File f = new File(outPath);
		if(!f.exists()){f.getParentFile().mkdirs();f.createNewFile();}
			
		
		output(param, new InputStreamReader(getClass().getResourceAsStream("/template/mybaits_mapper.xml.tl"))
				, new FileWriter(outPath));

	}
	
	
	
	private String class2FilePath(String cls,String basePath) {
		return basePath+"\\"+cls.replace(".", "\\")+".java";

	}
	

	/**
	 * 
	 * @param map
	 * @param inStream
	 * @param outStream
	 * @throws IOException
	 */
	public void output(Map<String, Object> map,Reader inStream,Writer outStream) throws IOException {
List<String> list = IOUtils.readLines(inStream);
		
		StringBuilder str = new StringBuilder();
		
		for (String string : list) {
			str.append(string);
			str.append("\n");
		}
		
		StringTemplateResourceLoader resourceLoader = new StringTemplateResourceLoader();
		Configuration cfg = Configuration.defaultConfiguration();
		GroupTemplate gt = new GroupTemplate(resourceLoader, cfg);
		Template t = gt.getTemplate(str.toString());
			t.binding(map);
		
		t.renderTo(outStream);

	}
	
	
	private Template getTemplate(String tl) throws IOException {
		StringTemplateResourceLoader resourceLoader = new StringTemplateResourceLoader();
		Configuration cfg = Configuration.defaultConfiguration();
		GroupTemplate gt = new GroupTemplate(resourceLoader, cfg);
		return gt.getTemplate(tl);

	}
	
	
	private String template(String tl,Map<String, Object> map) throws IOException {
		Template template = getTemplate(tl);
		template.binding(map);
		
		return template.render();

	}
	
}
