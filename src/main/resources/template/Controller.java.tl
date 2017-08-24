package com.foxtail.controller.server;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.common.page.Pagination;
import com.foxtail.common.web.DataGrid;
import com.foxtail.common.web.JsonResultFactory;
import ${enClass};
import ${serClass};

@Controller
@RequestMapping("server/${@enName.toLowerCaseFirst()}")
public class ${ctlName} extends BaseMybatisController{
	
	
	@Autowired
	${serName} ${@serName.toLowerCaseFirst()};
	
	
	@RequestMapping("tolist")
	public String toList() {
		
		return "server/${@enName.toLowerCaseFirst()}_tolist";

	}
	
	
	@RequestMapping("toadd")
	public String toadd() {
		
		return "server/${@enName.toLowerCaseFirst()}_toadd";

	}
	
	

	@RequestMapping("toedit")
	public String toedit(String id,ModelMap model) {
		
		model.put("vo", ${@serName.toLowerCaseFirst()}.queryById(id));
		
		
		return "server/${@enName.toLowerCaseFirst()}_toedit";

	}
	
	

	
	@RequestMapping("list")
	@ResponseBody
	public Object list(Integer limit,Integer offset) {
		Pagination pagination = new Pagination();
		pagination.setPageSize(limit);
		pagination.setOffset(offset);;
		
		pagination = ${@serName.toLowerCaseFirst()}.queryForPage(pagination);
		DataGrid dataGrid = new DataGrid();
	
		dataGrid.setTotal(pagination.getTotalCount());
		dataGrid.setRows(pagination.getList());
		
		return dataGrid;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
	
		String[] idArray = ids.split(ids);
		
		${@serName.toLowerCaseFirst()}.delete(idArray);
		
		return JsonResultFactory.getSuccessResult();
	}
	
	@RequestMapping("update")
	@ResponseBody
	public Object updaet(${enName} ${@enName.toLowerCaseFirst()}) {
	
		${@serName.toLowerCaseFirst()}.update(${@enName.toLowerCaseFirst()});
		
		return JsonResultFactory.getSuccessResult();
	}
	
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(${enName} ${@enName.toLowerCaseFirst()}) {
	
		
		
		${@serName.toLowerCaseFirst()}.save(${@enName.toLowerCaseFirst()});
		
		return JsonResultFactory.getSuccessResult();
	}

}
