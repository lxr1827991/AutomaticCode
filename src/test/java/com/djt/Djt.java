package com.djt;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.myEmis.Main;
import com.mysql.jdbc.StringUtils;

public class Djt {

	
	public static void main(String[] args) throws Exception {
		String string = "";
		for (int i = 0; i < 162; i++) {
			string+="444444,";
		}
		System.out.println(string);
		if (false) {
			return;
			
		}
		
		
		String str = readInfoStream(Main.class.getClassLoader().getResourceAsStream("djt/tmpl.txt"));
		
		
		 int col = 2;
		 int row = 162;
		 
			Integer srow = 101;
		 
		plan2(str,col,row,srow);
		
		
		String s2 = "124431,124113,334211,322434,114134,223314,121324,134421,112343,421124,323112,221344,234211,411342,134134,243134,141423,413411,214441,431224,224143,242144,114322,214124,314213,111423,214143,31244";
		System.out.println(s2.split(",").length);
		
		
		
	}
	
	
	public static void plan2(String str,int col,int row,int srow) {
		
		   
		 Pattern p = Pattern.compile("\\d{3}");      
     Matcher m = p.matcher(str);      
     str = m.replaceAll(",");  
		
     str = Pattern.compile("[生配兑供单双大小老少男女]|\\\\s*|\\t|\\r|\\n").matcher(str).replaceAll("");
    
    String[] arrs = str.split(",");
		System.out.println(arrs.length);
		
		
		String[] rets = new String[col];
		
		for (int i = 0; i < col; i++) {
			String[] arr = new String[row];
			for (int j = 0; j < row; j++) {
				arr[j] = arrs[i+j*col];
			}
			rets[i] = join(arr, ",").replaceAll(" ", "");
		}
		
		
	
		
		for (int i = 0; i < rets.length; i++) {
			String data = rets[i].substring(0, rets[i].length());
			System.out.println(toSql(data, srow+i));
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
			System.out.println(toSql(data, srow+i));
		}
		
		
		
	}
	
	
	
	
	private static void outData(String str,Integer col) {
		int row = str.length()/(col*6);
		
		for (int i = 0; i <row; i++) {
			System.out.println(str.substring(col*6*i, col*6*(i+1)));
			
		}

	}
	
	
	private static String toSql(String data,Integer row) {
		return "UPDATE djt_data_base SET d_data='"+data+"' WHERE d_tabl_num=10 AND d_rownum="+row+";";

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
