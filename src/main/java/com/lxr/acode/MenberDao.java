package com.lxr.acode;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foxtail.common.base.BaseMybatisDao;
import com.foxtail.common.page.Pagination;
import com.Menber;


public interface MenberDao extends BaseMybatisDao<Menber,String>{

	List<Menber> queryForPage(@Param("vo")Menber Menber,@Param("page")Pagination page);
	
	
	void delete(@Param("ids")String[] ids);
	
	
	void save(@Param("model")Menber Menber);
	
	void update(@Param("model")Menber Menber);
	
	
}
