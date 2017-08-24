package ${serPkg};

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foxtail.common.page.Pagination;
import ${daoClass};
import ${enClass};

@Service
public class ${serName} {
	
	@Autowired
	${daoName} ${@daoName.toLowerCaseFirst()};
	
	public Pagination queryForPage(Pagination pagination) {
		 List<${enName}> l = ${@daoName.toLowerCaseFirst()}.queryForPage(new ${enName}(), pagination);
		 pagination.setList(l);
		return pagination;

	}
	
	
	public ${enName} queryById(String id) {
		return ${@daoName.toLowerCaseFirst()}.selectByPrimaryKey(id);

	}
	
	
	public void delete(String[] ids) {
		
		${@daoName.toLowerCaseFirst()}.delete(ids);

	}
	
	public void update(${enName} ${@enName.toLowerCaseFirst()}) {
	
		${@daoName.toLowerCaseFirst()}.update(${@enName.toLowerCaseFirst()});

	}
	
	
	public void save(${enName} ${@enName.toLowerCaseFirst()}) {
		
		${@daoName.toLowerCaseFirst()}.save(${@enName.toLowerCaseFirst()});

	}
	
	

}
