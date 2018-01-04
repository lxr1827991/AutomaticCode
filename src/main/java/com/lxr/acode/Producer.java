package com.lxr.acode;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import org.apache.commons.io.IOUtils;
import org.beetl.core.Configuration;
import org.beetl.core.GroupTemplate;
import org.beetl.core.Template;
import org.beetl.core.resource.StringTemplateResourceLoader;
import org.beetl.ext.simulate.BaseSimulate.ReuqestBodyFunction;
import org.dom4j.DocumentException;

import com.lxr.commons.exception.ApplicationException;
import com.lxr.commons.utils.XmlUtils;

public class Producer {
	
	Map<String, String> config;
	
	Map<String, Object> vars = new HashMap<>();
	
	public Producer(String xml) {
		
			try {
				config = XmlUtils.xml2map(Producer.class.getResourceAsStream(xml));
			} catch (DocumentException e) {
				throw new ApplicationException(e);
			}
		
		
	}
	
	
	
	public String getVar(String key) {
		if(vars.get(key)!=null)
			return vars.get(key).toString();
		
		
		return (config.get(key)==null)?"":config.get(key).toString();
	}
	

	
	
	public Reader getTemplateFile(String path) {
		 return new InputStreamReader(getClass().getResourceAsStream(getVar("tlPath")+path));

	}
	
	
	
	
	public void outFile(Map<String, Object> map,Reader inStream,String path) throws IOException {
		
		File f = new File(path);
		
		if(f.exists()){
			System.out.println("已存在文件："+path);
			System.out.println("是否覆盖？y是t跳过");
			  Scanner scan = new Scanner(System.in);
			  String read = scan.nextLine();
			  switch (read) {
			case "y":
				return;
				
			case "t":
				break;

			default:
				break;
			}
		}
		
		if(!f.exists()){f.getParentFile().mkdirs();f.createNewFile();}
		
		output(map, inStream, new FileWriter(path));
		System.out.println("完成："+path);
	}
	
	
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
	

}
