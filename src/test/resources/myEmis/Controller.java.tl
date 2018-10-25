package $#{ctlPkg};

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.foxtail.common.AppModelMap;
import com.foxtail.common.DataGridResult;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import $#{enClass};
import $#{serClass};


@Controller
@RequestMapping("$#{modular}/$#{modular2}/$#{@enName.toLowerCaseFirst()}")
@AppModelMap("部门")
public class $#{ctlName} extends BaseMybatisController{

	@Autowired
	$#{serName} $#{@serName.toLowerCaseFirst()};
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction))
		modelMap.put("vo", $#{@serName.toLowerCaseFirst()}.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String sysType,HttpServletRequest request) {
		
		if("info".equals(sysType))
			return JsonResult.getSuccessResult($#{@serName.toLowerCaseFirst()}.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult($#{@serName.toLowerCaseFirst()}.findForPage(getPagination(request)));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save($#{enName} $#{@enName.toLowerCaseFirst()}) {
		
		$#{@serName.toLowerCaseFirst()}.save($#{@enName.toLowerCaseFirst()});

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		$#{@serName.toLowerCaseFirst()}.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update($#{enName} $#{@enName.toLowerCaseFirst()}) {
		
		$#{@serName.toLowerCaseFirst()}.update($#{@enName.toLowerCaseFirst()});

		return JsonResult.getSuccessResult();
	}
	
}
