package $#{serPkg};

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import $#{daoClass};
import $#{enClass};
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


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
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)$#{@daoName.toLowerCaseFirst()}.findForPage2();
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
		

	}
	
	
	public $#{enName} getById(String id) {
		
		return $#{@daoName.toLowerCaseFirst()}.getById(id);

	}

	
}


