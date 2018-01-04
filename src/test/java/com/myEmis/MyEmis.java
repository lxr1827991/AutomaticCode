package com.myEmis;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import org.beetl.core.Configuration;
import org.beetl.core.GroupTemplate;
import org.beetl.core.Template;
import org.beetl.core.resource.StringTemplateResourceLoader;
import com.lxr.acode.Producer;
import com.lxr.acode.TlBean;

/**
 * 
 */
public class MyEmis extends Producer{
	
	public MyEmis(String xml) {
		super(xml);
	}
	
	public static void main(String[] args) throws IOException {
		
		MyEmis myEmis = new MyEmis("/myEmis/config.xml");
		
		
		String basePath = myEmis.getVar("basePath");
		
	
		String enname = "Examine";
		String tbname = "man_examine";
		String modular = "personnel";
		String modular2 = "examine";
		
	
		
		Map<String, Object> map = myEmis.excute(basePath, enname, tbname, modular,modular2);
		map.put("modular2", modular2);
		
		System.out.println("开始");
		myEmis.createEditJspFile(map);
		myEmis.createMainJspFile(map);
		myEmis.crateController(map);
		myEmis.createMapperFile(map);
		myEmis.crateDao(map);
		myEmis.createService(map);
		System.out.println("结束");
	
	}
	
	
	private Map<String, Object> excute(String basePath,String enname,String tbname,String modular,String modular2) {
		Map<String, Object> map = new HashMap<String, Object>();
		
	String enclass  = "com.foxtail.model."+modular+"."+enname;
		
		
		
		String daoPkg = "com.foxtail.dao.mybatis."+modular;
		String daoclass = daoPkg+"."+enname+"Dao";
		String daoname  = daoclass.substring(daoclass.lastIndexOf(".")+1);
		
		String serPkg = "com.foxtail.service."+modular;
		String serclass = serPkg+"."+enname+"Service";
		String sername = serclass.substring(serclass.lastIndexOf(".")+1);
		
		
		map.put("basePath", basePath);
		//模块名称
		map.put("modular", modular);
		
		
		
		map.put("enClass", enclass);
		map.put("enName",new TlBean(enname));
		
		map.put("daoPkg", daoPkg);
		map.put("daoClass", daoclass);
		map.put("daoName", new TlBean(daoname));
		
		map.put("serPkg", serPkg);
		map.put("serClass", serclass);
		map.put("serName", new TlBean(sername));
		
		
		String mppath = "com\\foxtail\\mapping\\"+modular+"\\"+new TlBean(enname).toLowerCaseFirst()+"_mapper.xml";
		
		
		map.put("mpPath", mppath);
		map.put("tbName", tbname);
		
		
		String ctlPkg = "com.foxtail.controller."+modular;
		String ctlClass = ctlPkg+"."+enname+"Controller";
		String ctlName  = ctlClass.substring(ctlClass.lastIndexOf(".")+1);
		map.put("ctlPkg", ctlPkg);
		map.put("ctlClass", ctlClass);
		map.put("ctlName", new TlBean(ctlName));
		
		
		
		String jspBase = new File(basePath).getParent()+"/webapp/jsp/"+modular+"/"+modular2;
		
		map.put("jspBase", jspBase);
		map.put("jspMain", new TlBean(enname).toLowerCaseFirst()+"_main.jsp");
		map.put("jspEdit", new TlBean(enname).toLowerCaseFirst()+"_edit.jsp");
		
		
		return map;

	}
	
	/**
	 * 
	 * @param map
	 * @throws IOException
	 */
	public void crateController(Map<String, Object> map) throws IOException {
		Map<String, Object> param = new HashMap<String, Object>();
		param.putAll(map);
		
		String outPath = class2FilePath(param.get("ctlClass").toString(),param.get("basePath").toString());
			
		outFile(param, getTemplateFile("Controller.java.tl"), outPath);

	}
	
	/**
	 * 
	 * @param map
	 * @throws IOException
	 */
	public void crateDao(Map<String, Object> map) throws IOException {
		Map<String, Object> param = new HashMap<String, Object>();
		param.putAll(map);
		
		String outPath = class2FilePath(param.get("daoClass").toString(),param.get("basePath").toString());
		
		
		outFile(param, getTemplateFile("Dao.java.tl"), outPath);

	}
	
	/**
	 * 
	 * @param map
	 * @throws IOException
	 */
	private void createService(Map<String, Object> map) throws IOException {
		Map<String, Object> param = new HashMap<String, Object>();
		param.putAll(map);
		
		String outPath = class2FilePath(param.get("serClass").toString(),param.get("basePath").toString());
		
		outFile(param,getTemplateFile("Service.java.tl"), outPath);

	}
	
	/**
	 * 
	 * @param map
	 * @throws IOException
	 */
	public void createMapperFile(Map<String, Object> map) throws IOException {
	
		Map<String, Object> param = new HashMap<String, Object>();
		param.putAll(map);
		
		String outPath =param.get("basePath").toString()+"\\"+param.get("mpPath").toString();
		
		outFile(param,getTemplateFile("mapper.xml.tl"), outPath);
			

	}
	
	
	public void createEditJspFile(Map<String, Object> map) throws IOException {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.putAll(map);
		
		String outPath =param.get("jspBase").toString()+"/"+param.get("jspEdit").toString();
		
		outFile(param,getTemplateFile("edit.jsp.tl"), outPath);
		
		System.out.println("");
		

	}
	public void createMainJspFile(Map<String, Object> map) throws IOException {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.putAll(map);
		
		String outPath =param.get("jspBase").toString()+"/"+param.get("jspMain").toString();
		
		outFile(param,getTemplateFile("main.jsp.tl"), outPath);
			

	}
	
	
	
	private String class2FilePath(String cls,String basePath) {
		return basePath+"\\"+cls.replace(".", "\\")+".java";

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


