<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${namespace}">
	
	
<resultMap type="${enClass}" id="model"></resultMap>

	<sql id="Base_Column_List">
		id,no,'' head,name nickname,'' regMode,null regDate,0 amount
	</sql>

	 <!-- 分页数据 -->    
	<select id="queryForPage" resultMap="model" >
  		select  <include refid="Base_Column_List" /> from fa_biz_member
  	</select>      
  
  
  
	<!-- 根据主键获取对象 -->  
	<select id="selectByPrimaryKey" resultMap="model" parameterType="string" >
	  select 
	  <include refid="Base_Column_List" />
	  from fa_biz_member
	  
	  where id = #{id,jdbcType=string}
	</select>
	
	
	<insert id="save" >
	
	
	
	</insert>	


</mapper>   
