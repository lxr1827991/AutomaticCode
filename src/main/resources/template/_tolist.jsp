<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>	
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询列表</title>
<script>
var toAddUrl = '${path}/server/menber/toadd.do';
var deleteUrl = '${path}/server/menber/delete.do';
var toEditUrl = '${path}/server/menber/toedit.do';
var toInfoUrl = '${path}/server/menber/toinfo.do';

	//添加
	function toAdd(){
		window.location=toAddUrl;
	}
	//删除
	function toRemove(){
		var ids=getSelectedRowsIds('SysUserList');
		if(ids){
			top.showConfirmDiaglog('提示','删除数据不可恢复，确定要删除吗？',function(){  //关闭事件
				refleshData('SysUserList');
			},function(){  //确认事件
				 $.post(deleteUrl+'?ids='+ids,function(){
					var json=$.parseJSON(data);
				    if(json.success){
				    	top.showArtDiaglog('提示','删除成功',function(){  //关闭事件
				    		refleshData('SysUserList');
	 					},function(){   //确定事件
	 						top.closeDialog();
	 					});
				    }else{
				    	top.showArtDiaglog('提示','删除失败',function(){  //关闭事件
	 					},function(){   //确定事件
	 						top.closeDialog();
	 					});
				    }
				 });
			});
		}else{
			top.showArtDiaglog('提示','请选择一条数据进行操作',null,function(){
				top.closeDialog();
			});
		}
	}
	
	//编辑
    function toEdit(){
    	var selected=getSelectedRowsArr('SysUserList');
    	if(selected.length>0&&selected.length<2){
    		window.location=toEditUrl+'?id='+selected;
    	}else{
    		//提示信息
    		top.showArtDiaglog('提示','请选择一条数据进行操作',null,function(){
    			top.closeDialog();
			});
    	}
	}
	
    //查看
    function toInfo(){
    	var selected=getSelectedRowsArr('SysUserList');
    	if(selected.length>0&&selected.length<2){
    		window.location=toInfoUrl+'?id='+selected;
    		
    	}else{
    		top.showArtDiaglog('提示','请选择一条数据进行操作',null,function(){
    			top.closeDialog();
			});
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
    	$('#SysUserList').bootstrapTable('refresh');
    }
    
    function editById(id){
		window.location=toEditUrl+'?id='+id;
	}

	//根据id删除
	function deleteById(id){
		top.showConfirmDiaglog('提示','删除数据不可恢复，确定要删除吗？',function(){  //关闭事件
				refleshData('SysUserList');
			},function(){  //确认事件
				 $.post('${path}/menber/delete.do?ids='+id,function(data){
				   var json=$.parseJSON(data);
				   if(json.success){
					   top.showArtDiaglog('提示','删除成功',function(){  //关闭事件
						   refleshData('SysUserList');
	 					},function(){   //确定事件
	 						top.closeDialog();
	 					});
				   }else{
					   top.showArtDiaglog('提示','删除失败',function(){  //关闭事件
	 					},function(){   //确定事件
	 						top.closeDialog();
	 					});
				   }
			});
		});
	}

	//根据id查看
	function viewById(id){
			window.location=toInfoUrl+'?id='+id;
	}
	
    //操作工具栏
    function operatorFormatter(value, row, index) {
    	var operator="";
	    	<shiro:hasPermission name="menber:edit">
	    		operator+='<button class="btn btn-warning btn-round btn-xs" onclick="editById(\''+row.id+'\');"><i class="glyphicon glyphicon-pencil"></i> 修改</button>&nbsp;&nbsp;';
		    </shiro:hasPermission>
		    <shiro:hasPermission name="menber:info">
				operator+='<button class="btn btn-success btn-round btn-xs" onclick="viewById(\''+row.id+'\')"><i class="glyphicon glyphicon-list-alt"></i>详情</button>&nbsp;&nbsp;';
	    	</shiro:hasPermission>
	    	<shiro:hasPermission name="menber:delete">
				operator+='<button class="btn btn-danger btn-round btn-xs" onclick="deleteById(\''+row.id+'\')"><i class="glyphicon glyphicon-trash"></i>删除</button>';
			</shiro:hasPermission>
		return operator;
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
    
    
    //格式化状态
    function regModeFormatter(value,row,index){
    	if(value=='1'){
    		return 'app';
    	}else{
    		return "其他";
    	}
    }
    
    //格式化用户类型
        function exportExcel(){
    	var titles = [];
    	var attributes = [];
    		$("#SysUserList").find("th").each(function(i) {
    			if (i != 0) {
    				var title = $.trim($(this).text())
    				if(title!="操作"){
    					titles.push(title);
    					titles.join(",")
    				}
    			}
    		});
    		$("#SysUserList").find("th").each(function(i) {
    			if (i != 0) {
    				var attribute = $.trim($(this).attr("data-field"));
    				if(attribute!="operator"){
    					attributes.push(attribute);
    					attributes.join(",")
    				}
    			}
    		});
    		$("#name2").val($("#name1").val());
    		$("#exportForm").attr("action",encodeURI(encodeURI("/EMIS_MAVEN/excelManagerController/exportExcel.do?headTitle="+titles+"&headers="+attributes)));
    		$("#exportForm").serialize()
    		$("#exportForm").submit();
    		//window.location = encodeURI(encodeURI("/EMIS_MAVEN/excelManagerController/exportExcel.do?headTitle="+titles+"&headers="+attributes));
    	}
    
    function setUser(){
    	var selected=getSelectedRowsArr('SysUserList');
    	if(selected.length>0&&selected.length<2){
    		var dialog = art.dialog.open("${path}/sysRoleController/toUserRoleTree.do?userId="+selected,{
    	  		  id:"selectResourceDialog",
    	  		  title:"选择人员",
    	  		  width :'300px',
    	  		  height:'380px',
    	  		  lock:true,
    	  		  init: function (){
    		  		$(this.iframe).attr("scrolling","no");//去掉滚动条
    		  	  },
    	  		  close:function(){
    	  			  
    	  		  }
    	  	});
    	}else{
    		//提示信息
    		top.showArtDiaglog('提示','请选择一条数据进行操作',null,function(){
    			top.closeDialog();
			});
    	}
    }
    
    function closeDialog(){
    	art.dialog.list["selectResourceDialog"].close();
    }
    
</script>
</head>
<body>
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">数据表</a></li>
    <li><a href="#">基本内容</a></li>
    </ul>
    </div>
    
    <div class="rightinfo">
		<div>
    		<form id="searchForm" name="searchForm"  method="post">
    			<label>用户名：</label><input type="text" name="userName" class="txtSearch">&nbsp;
    			<input type="button" class="btn btn-info btn-round" value="查询" onclick="queryList()">&nbsp;&nbsp;
    			<input type="button" class="btn btn-warning btn-round" value="重置" onclick="$('#searchForm')[0].reset();"> 
    		</form>
    	</div>
	    <div id="toolbar" class="btn-group">
	    	<shiro:hasPermission name="menber:add">
		    	<button class="btn btn-info btn-round" onclick="toAdd();">
					<i class="glyphicon glyphicon-plus"></i>添加
				</button>
		    </shiro:hasPermission>
	    	<shiro:hasPermission name="menber:edit">
	    		<button class="btn btn-warning btn-round" onclick="toEdit();">
					<i class="glyphicon glyphicon-pencil"></i> 修改
				</button>
	    	</shiro:hasPermission>
			<shiro:hasPermission name="menber:info">
				<button class="btn btn-success btn-round" onclick="toInfo()">
					<i class="glyphicon glyphicon-list-alt"></i>详情
				</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="menber:delete">
				<button class="btn btn-danger btn-round" onclick="toRemove()">
					<i class="glyphicon glyphicon-trash"></i>删除
				</button>
			</shiro:hasPermission>
			
		</div>
    
    	<table id="SysUserList" data-toggle="table"
			data-url="${path}/server/menber/list.do" data-pagination="true"
			data-side-pagination="server" data-cache="false" data-query-params="postQueryParams"
			data-page-list="[10, 15, 20, 30, 50,100]" data-method="post"
			data-show-refresh="true" data-show-toggle="true"
			data-show-columns="true" data-toolbar="#toolbar"
			data-click-to-select="true" data-single-select="false"
			data-striped="true" data-content-type="application/x-www-form-urlencoded"
			>
			<thead>
				<tr>
				
					<th data-field="" data-checkbox="true"></th>
					<th data-field="id" >停车服务号</th>
					<th data-field="mobile">用户名</th>
					<th data-field="head" data-formatter="Formatter.img">头像</th>
					<th data-field="nickname">昵称</th>
					<th data-field="regMode" data-formatter="Formatter.date">注册方式</th>
					<th data-field="regDate">注册时间</th>
					<th data-field="amount"  >钱包余额</th>
					<th data-field="operator" data-formatter="operatorFormatter">操作</th>
				</tr>
			</thead>
		</table>
    </div>
</body>
</html>