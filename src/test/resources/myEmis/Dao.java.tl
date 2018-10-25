package $#{daoPkg};

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import $#{enClass};

public interface $#{daoName} {

	void save(@Param("model")$#{enName} $#{@enName.toLowerCaseFirst()});
	
	void update(@Param("model")$#{enName} $#{@enName.toLowerCaseFirst()});
	
	$#{enName} getById(@Param("id")String id);
	
	List<$#{enName}> findForPage2();
}

