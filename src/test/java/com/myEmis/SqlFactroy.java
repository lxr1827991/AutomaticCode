package com.myEmis;

import java.io.IOException;

public class SqlFactroy {

	
	public static void main(String[] args) throws IOException {
		String str = "ordercode`, `uid`, `account`, `channel`, `money`, `third_code`, `business_type`, `business_data`, `createtime`, `remark`";
		
		String table = "tra_order";
		
		str = str.replaceAll("`", "");
		
		//System.out.println(str);
		String [] ss = str.split(",");
		
		String out ="";
		for (String string : ss) {
			out+=",#{ mo."+string.trim()+" }";
		}
		String out2 = "";
		for (String string : ss) {
			out2+=","+string.trim()+"=#{ mo."+string.trim()+" }\n";
		}
		
		out = out.replaceFirst(",", "");
		out2 = out2.replaceFirst(",", "");
		
		System.out.println("UPDATE "+table+" SET "+out2+" WHERE id=#{model.id}");
		
		System.out.println("INSERT INTO "+table+ "("+str+") VALUES("+out+")");
		
	}
	
}
