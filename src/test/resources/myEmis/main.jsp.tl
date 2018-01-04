<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>	
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询列表</title>
<script>
var toAddUrl = '${path}/$#{modular}/$#{modular2}/$#{@enName.toLowerCaseFirst()}/toedit.do';
var deleteUrl = '${path}/$#{modular}/$#{modular2}/$#{@enName.toLowerCaseFirst()}/delete.do';
var toEditUrl = '${path}/$#{modular}/$#{modular2}/$#{@enName.toLowerCaseFirst()}/toedit.do';
var toInfoUrl = '${path}/$#{modular}/$#{modular2}/$#{@enName.toLowerCaseFirst()}/view.do';

	//添加
	function toAdd(){
		
		window.location=toAddUrl;
	}
	//删除
	function toRemove(id){
		
		var ids = id;
		if(!id)ids=getSelectedRowsIds('mainTable');
		
		if(ids){
			
			$app.confirmDelete(deleteUrl+'?ids='+ids,'删除数据不可恢复，确定要删除吗？'
					,function(){
				refleshData('mainTable');
			});
			
			
			
		}else{
			$app.alert("请选择一条数据进行操作");
		}
	}
	
	//编辑
    function toEdit(){
    	var selected=getSelectedRowsArr('mainTable');
    	if(selected.length>0&&selected.length<2){
    		window.location=toEditUrl+'?id='+selected+"&sysAction=edit";
    	}else{
    		//提示信息
    		$app.alert('请选择一条数据进行操作');
    		
    	}
	}
	
    //查看
    function toInfo(){
    	var selected=getSelectedRowsArr('mainTable');
    	if(selected.length>0&&selected.length<2){
    		
    		$lxr.modal({url:toInfoUrl+'?id='+selected});
    		
    	}else{
    		$app.alert('请选择一条数据进行操作');
    	}
	}
	
	//设置查询参数
	function postQueryParams(params) {
		var queryParams = $("#searchForm").serializeObject();
		queryParams.limit=params.limit;
		queryParams.offset=params.offset;
		return queryParams;
	}
	//查询列表
    function queryList(){
    	$('#mainTable').bootstrapTable('refresh');
    }
    
    function editById(id){
		window.location=toEditUrl+'?id='+id+"&sysAction=edit";
	}

	

	//根据id查看
	function viewById(id){
		$lxr.modal({url:toInfoUrl+'?id='+id+"&type=info"});
	}
	
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator='<div class="btn-group">';
		    
	    	<shiro:hasPermission name="personnel/organize/place:edit">
	    		operator+='<button class="btn btn-warning btn-round btn-xs" onclick="editById(\''+row.id+'\');"><i class="glyphicon glyphicon-pencil"></i> 编辑</button>&nbsp;&nbsp;';
		    </shiro:hasPermission>
		    <shiro:hasPermission name="personnel/organize/place:delete">
				operator+='<button class="btn btn-danger btn-round btn-xs" onclick="toRemove(\''+row.id+'\')" ><i class="glyphicon glyphicon-trash"></i> 删除</button>';
	    	</shiro:hasPermission>
	    	/* <shiro:hasPermission name="menber:delete">
				operator+='<button class="btn btn-danger btn-round btn-xs" onclick="deleteById(\''+row.id+'\')"><i class="glyphicon glyphicon-trash"></i>删除</button>';
			</shiro:hasPermission> */
		return operator+'</div>';
	}
    
    //格式化状态
    function statusFormatter(value,row,index){
    	if(value=='1'){
    		return '<span class="label label-success label-lg">启用</span>';
    	}else if(value=='2'){
    		return '<span class="label label-danger arrowed">锁定</span>';
    	}else{
    		return "";
    	}
    }
    
 
    
</script>
</head>
<body class="mlr15">

    
    <div class="rightinfo explain_col">
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
    			
    			<span>关键词：</span>
    			<input name="kw" value="" placeholder="手机号,昵称"  class="form-control input-sm w200" type="text" style="display: inline;" >
    			<input type="button" class="btn btn-info btn-round btn-sm" value="查询" onclick="queryList()">
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	   
	   <button class="btn btn-info btn-round  btn-sm" onclick="toAdd();" >
					<i class="glyphicon glyphicon-plus"></i> 添加
		</button>
		</div>
    </div>
    	<table class="table_list" id="mainTable" data-toggle="table"
			data-url="${path}/$#{modular}/$#{modular2}/$#{@enName.toLowerCaseFirst()}/view.do" data-pagination="ture" 
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
			data-page-list="[15, 30, 50, 100]" data-page-size= "15" data-method="post"
			data-show-refresh="false" data-show-toggle="false"
			data-show-columns="false" data-toolbar="#toolbar"
			data-click-to-select="false" data-single-select="false"
			data-striped="false" data-content-type="application/x-www-form-urlencoded"
			>
			<thead>
				<tr>
				
					<th data-field="" data-checkbox="true"></th>
					<!-- <th data-field="sort" data-formatter="Formatter.sort">序号</th> -->
					<th data-field="id" >id</th>
					<th data-field="name" >名称</th>
					
					<th data-field="state"  >状态</th>
					<th data-field="operator" data-formatter="operatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
		
    </div>
     <label class="select_all"><input type="checkbox" name="checkall" onclick="  $('#mainTable thead input[name=btSelectAll]').click()" class="J_checkall">全选/取消</label>
   <button class="btn btn-danger btn-round btn-xs" onclick="toRemove()"><i class="glyphicon glyphicon-trash"></i> 批量删除</button>

</body>
</html>