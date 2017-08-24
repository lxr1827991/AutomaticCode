package com.lxr.acode;

public class TlBean {
	
	String str;
	
	public TlBean(String s) {
		str = s;
	}

	
	//首字母转小写
	public String toLowerCaseFirst(){
	  if(Character.isLowerCase(str.charAt(0)))
	    return str;
	  else
	    return (new StringBuilder()).append(Character.toLowerCase(str.charAt(0))).append(str.substring(1)).toString();
	}
	
	@Override
	public String toString() {
		return str;
	}
}
