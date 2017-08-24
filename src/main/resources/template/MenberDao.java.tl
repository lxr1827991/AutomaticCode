package ${daoPkg};

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foxtail.common.base.BaseMybatisDao;
import com.foxtail.common.page.Pagination;
import ${enClass};


public interface ${daoName} extends BaseMybatisDao<${enName},String>{

	List<${enName}> queryForPage(@Param("vo")${enName} ${@enName.toLowerCaseFirst()},@Param("page")Pagination page);
	
	
	void delete(@Param("ids")String[] ids);
	
	
	void save(@Param("model")${enName} ${@enName.toLowerCaseFirst()});
	
	void update(@Param("model")${enName} ${@enName.toLowerCaseFirst()});
	
	
}
