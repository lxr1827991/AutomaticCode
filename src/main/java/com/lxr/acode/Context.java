package com.lxr.acode;

import java.io.File;
import java.util.Map;
import java.util.Properties;

public class Context {

	
	
	Map<String, String> config;
	
	public String getPropertie(String key) {
		return config.get(key);

	}

	
	
	public Map<String, String> getConfig() {
		return config;
	}



	public void setConfig(Map<String, String> config) {
		this.config = config;
	}



	public String getFile(String rpath) {
		
		return  getPropertie("basePath")+rpath;

	}
	
	
	public String getPropertieFile(String p) {
		return getFile(getPropertie(p));

	}
	
}
