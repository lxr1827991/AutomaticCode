<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="$#{daoClass}">
	
	<sql id="base_column">
		a.*
	</sql>

	  
	<select id="findForPage2" resultType="$#{enClass}" >
  		select  <include refid="base_column" /> from $#{tbName} a
  	</select>
  
		
	<select id="getById" resultType="$#{enClass}" >
  		select  <include refid="base_column" /> from $#{tbName} a where a.id=#{id}
  	</select> 

	
	
	<update id="update" >
	   update $#{tbName} set
		  	name = #{model.name}
	   where id = #{model.id}
	</update>

	 <!-- 根据对象主键更新 -->
  	<insert id="save"  >
     INSERT INTO $#{tbName} (name) VALUES (#{model.name})
     </insert>
	
  	
  
</mapper>   
