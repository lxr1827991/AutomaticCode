package com.djt;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.beetl.core.statement.VarAssignExpression;

import com.myEmis.Main;

public class Djz {

	
	
	public static void main(String[] args) throws Exception {
		String string = "";
		for (int i = 0; i < 162; i++) {
			string+="444444,";
		}
		System.out.println(string);
		if (false) {
			return;
			
		}
		
		
		String str = readInfoStream(Main.class.getClassLoader().getResourceAsStream("djt/djz.txt"));
		
		
		 int col = 2;
		 int row = 182;
		 
			Integer srow = 101;
		 
		plan2(str,col,row,srow);
		
		
		
		
		
	}
	
	
	public static void plan2(String str,int col,int row,int srow) {
		
		   
		 Pattern p = Pattern.compile("\\r");      
     Matcher m = p.matcher(str);      
     str = m.replaceAll(",");  
		
     str = Pattern.compile("[生配兑供单双大小老少男女]|\\\\s*|\\t|\\r|\\n").matcher(str).replaceAll("");
    
    String[] arrs = str.split(",");
		System.out.println(arrs.length);
		
		
		String[] rets = new String[row];
		
		int index = 0;
		
		for (int i = 0; i < arrs.length; i++) {
			if(index>=rets.length) {
				System.err.println("出现多余的数据下标"+i);
				break;
			}
			
			if(arrs[i]==null||arrs[i].trim().equals(""))continue;
			rets[index] = arrs[i].trim();
			index ++;
			
		}
		
		
	
		
		for (int i = 0; i < rets.length; i++) {
			String data = rets[i].substring(0, rets[i].length());
			System.out.println(updateSql(data, i-1));
		}
		
		
		
	}
	
	public static void plan1(String str) {
		
		   
		 Pattern p = Pattern.compile("\\d{3}|[生配兑供单双大小老少男女]|\\s*|\t|\r|\n");      
      Matcher m = p.matcher(str);      
      str = m.replaceAll("");  
		  
     int col = 100;
     outData(str,col);
        
		String[] rets = new String[col];
		
		
		int n = str.length()/(6*col);
		
		
		for (int i = 0; i < n; i++) {
			for (int j = 0; j < col; j++) {
				
				int s = (6*col)*i+(j*6);
				int e = s+6;
				if(rets[j]==null)rets[j] = "";
				rets[j]+= ","+str.substring(s, e);
				
			}
			
		}
		
		
		Integer srow = 1;
		
		for (int i = 0; i < rets.length; i++) {
			String data = rets[i].substring(1, rets[i].length());
			System.out.println(updateSql(data, srow+i));
		}
		
		
		
	}
	
	
	
	
	private static void outData(String str,Integer col) {
		int row = str.length()/(col*6);
		
		for (int i = 0; i <row; i++) {
			System.out.println(str.substring(col*6*i, col*6*(i+1)));
			
		}

	}
	
	
	
	private static String insetSql(String data,Integer row) {
		return "INSERT INTO data_base (`sheng`, `row`, `tabl_num`) VALUES ('"+data+"', '"+row+"', '6');";

	}
	
	private static String updateSql(String data,Integer row) {
		return "UPDATE data_base SET sheng='"+data+"' WHERE tabl_num=9 AND row="+row+";";

	}
	
	
	private static final String DEFAULT_ENCODING = "Utf-8";//编码  
	private static final int PROTECTED_LENGTH = 1204000;// 输入流保护 50KB  
	  
	public static String readInfoStream(InputStream input) throws Exception {  
	    if (input == null) {  
	        throw new Exception("输入流为null");  
	    }  
	    //字节数组  
	    byte[] bcache = new byte[2048];  
	    int readSize = 0;//每次读取的字节长度  
	    int totalSize = 0;//总字节长度  
	    ByteArrayOutputStream infoStream = new ByteArrayOutputStream();  
	    try {  
	        //一次性读取2048字节  
	        while ((readSize = input.read(bcache)) > 0) {  
	            totalSize += readSize;  
	            if (totalSize > PROTECTED_LENGTH) {  
	                throw new Exception("输入流超出50K大小限制");  
	            }  
	            //将bcache中读取的input数据写入infoStream  
	            infoStream.write(bcache,0,readSize);  
	        }  
	    } catch (IOException e1) {  
	        throw new Exception("输入流读取异常");  
	    } finally {  
	        try {  
	            //输入流关闭  
	            input.close();  
	        } catch (IOException e) {  
	            throw new Exception("输入流关闭异常");  
	        }  
	    }  
	  
	    try {  
	        return infoStream.toString(DEFAULT_ENCODING);  
	    } catch (UnsupportedEncodingException e) {  
	        throw new Exception("输出异常");  
	    }  
	}  
	
	  private static String join(String[] strs,String splitter) {
	        StringBuffer sb = new StringBuffer();
	        for(String s:strs){
	            sb.append(s+splitter);
	        }
	        return sb.toString().substring(0, sb.toString().length()-1);
	    }
}
