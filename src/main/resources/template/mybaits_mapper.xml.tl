<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${daoClass}">
	
	
<resultMap type="${enClass}" id="model"></resultMap>
<parameterMap type="${enClass}" id="pmodel"/>

	<sql id="Base_Column_List">
		
	</sql>

	 <!-- 分页数据 -->    
	<select id="queryForPage" resultMap="model" >
  		select  <include refid="Base_Column_List" /> from ${tbName}
  	</select>      
  
  
  
	<!-- 根据主键获取对象 -->  
	<select id="selectByPrimaryKey" resultMap="model" parameterType="string" >
	  select 
	  <include refid="Base_Column_List" />
	  from ${tbName}
	  
	  where id = #{id,jdbcType=string}
	</select>
	
	
	
  <!--批量删除-->
	<delete id="delete" >
	   delete from ${tbName}
	   where id in
	      <foreach collection="ids" item="id" index="index" open="(" close=")" separator=",">
              #{id,jdbcType=INTEGER}
          </foreach>
	</delete>
	
	<update id="update" parameterMap="pmodel" >
       update ${tbName}
       set                                        
	      id = #{id,jdbcType=INTEGER},
	      name = #{name,jdbcType=VARCHAR},
	      nickname = #{account,jdbcType=VARCHAR},
	      status = #{status,jdbcType=INTEGER}
	   where id = #{id}
  	</update>	
  	
  	
  	<!-- 保存对象 -->
 	<insert id="insert" parameterMap="pmodel" useGeneratedKeys="true" keyProperty="id">
       </insert>


</mapper>   
