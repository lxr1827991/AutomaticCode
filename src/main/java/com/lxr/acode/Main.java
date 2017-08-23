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
	
	
	public static void main(String[] args) throws IOException {
		
		Main main = new Main();
		main.init();
		
		//main.templateMapperFile();
		main.crateDao();
		System.out.println("ok");
	}
	
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
	
	
	public void crateDao() throws IOException {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("package", "com.lxr.acode");
		param.put("daoName", "MenberDao");
		String enclass = "com.Menber";
		param.put("enClass", enclass);
		String enname  = enclass.substring(enclass.lastIndexOf(".")+1);
		param.put("enName",enname);
		
		
		String outPath = template(context.getPropertieFile("mybatis.out.daoPath"), param);
		
		output(param, new InputStreamReader(getClass().getResourceAsStream("/template/MenberDao.java"))
				, new FileWriter(outPath));

	}
	
	
	public void templateMapperFile() throws IOException {
	
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		
		
		param.put("namespace", "com.");
		String enclass = "com.nenber";
		param.put("enClass", enclass);
		String enname  = enclass.substring(enclass.lastIndexOf(".")+1);
		param.put("enName",enname);
		
		
		String outPath = context.getPropertieFile("mybatis.out.mapperPath");
		
		output(param, new InputStreamReader(getClass().getResourceAsStream("/template/mybaits_mapper.xml.tl"))
				, new FileWriter(outPath));

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
