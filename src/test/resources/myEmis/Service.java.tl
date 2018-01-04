package $#{serPkg};

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import $#{daoClass};
import $#{enClass};


@Service
public class $#{serName} {

	@Autowired
	$#{daoName} $#{@daoName.toLowerCaseFirst()};
	
	
	public void save($#{enName} $#{@enName.toLowerCaseFirst()}) {
		
		$#{@daoName.toLowerCaseFirst()}.save($#{@enName.toLowerCaseFirst()});

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("$#{tbName}", ids);

	}
	
	
	public void update($#{enName} $#{@enName.toLowerCaseFirst()}) {
	
		$#{@daoName.toLowerCaseFirst()}.update($#{@enName.toLowerCaseFirst()});

	}
	
	public Pagination findForPage(Pagination page) {
		
		List  list = $#{@daoName.toLowerCaseFirst()}.findForPage(page);
		page.setList(list);
		return page;

	}
	
	
	public $#{enName} getById(String id) {
		
		return $#{@daoName.toLowerCaseFirst()}.getById(id);

	}

	
}


