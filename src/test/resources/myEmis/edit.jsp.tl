<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/common/global.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑页面</title>
<script type="text/javascript">

var depts = [];


var backurl = "${path}/$#{modular}/$#{modular2}/$#{@enName.toLowerCaseFirst()}.do";


	$(function() {
		
		
	
	});
	function toSubmit(){
		//表单验证
		
		if(!$("#submit_form").valid())
				return;
		
		
		$app.loading(function(onfinsh){
		//表单提交
		$("#submit_form").ajaxSubmit({
			url:$("#submit_form").attr("data-action"),
			data : $("#submit_form").serialize(),
			cache : false,
			dataType : 'JSON',
			type:'post',
			success:function(data){
				if(data.status==0){
					$app.alert('编辑成功',function(){  //关闭事件
						goBackList();
					});
				
				}else
					$app.alert('编辑失败');
				
			}
		});
		
		});
	}
	
	//返回列表
	function goBackList(){
		try {
			var index = parent.layer.getFrameIndex(window.name);
			parent.layer.close(index);
		} catch (e) {

			if(isNaN(index))window.location=backurl;
		}
		
	}
	
</script>
	<script type="text/javascript">
	$(document).ready(function () {
		 var validateOpts = {
		  rules: {
		name: {required: true}
		
		 
		 
		  }
		/*   ,
		  messages: {
		   name: {
		    required: "hiik"
		   },
		   sort: {
		    required: "请输入密码" 
		   }
		  } */
		 };
		 
		 $("#submit_form").validate(validateOpts);
		});
</script>
</head>
<body>
	<div>
		
		<div class="formbody">

<c:if test="${empty param.sysAction}">
		
   			<div class="formtitle"><span>基本信息</span></div>
   			<form id="submit_form" data-isadd="true" method="post" data-action="${path}/$#{modular}/$#{modular2}/$#{@enName.toLowerCaseFirst()}/save.do">
   				<ul class="forminfo">
					<li><label>级别：</label><input name="name" type="text" type="text" class="form-control input-primary w260" />
					</li>
					
					<li><label>餐补：</label><input name="subs_meal"  value="" type="text" class="form-control input-primary w260" />
				
					
					<li><label>备注：</label><input name="remark"  value="" type="text" class="form-control input-primary w260" />
					</li>
					
				<li><label>状态：</label>
					<input type="radio"  name="state" value="0" checked="checked">启用
					<input type="radio"  name="state" value="1"  >禁用
				</li>
					
					
					
	    			<li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="button" class="btn btn-warning" value="返回列表" onclick="goBackList();"/></li>
	    		</ul>
    		</form>
    		
</c:if>

<c:if test="${param.sysAction=='edit'}">

<div class="formtitle"><span>基本信息</span></div>
   			<form id="submit_form"  method="post" data-action="${path}/$#{modular}/$#{modular2}/$#{@enName.toLowerCaseFirst()}/update.do">
   				<input name="id" value="${vo.id }" type="hidden" class="form-control input-primary w260" />
   				<ul class="forminfo">
					<li><label>级别：</label><input name="name" value="${vo.name }" type="text" class="form-control input-primary w260" />
					</li>
					
				
					
					<li><label>备注：</label><input name="remark"  value="${vo.remark }" type="text" class="form-control input-primary w260" />
					</li>
					
				<li><label>状态：</label>
					<input type="radio"  name="state" value="0" <c:if test="${vo.state==0}">checked="checked"</c:if>>启用
					<input type="radio"  name="state" value="1" <c:if test="${vo.state==1}">checked="checked"</c:if>>禁用
				</li>
					
					
					
	    			<li><label>&nbsp;</label><input name="" type="button" class="btn btn-primary" value="确认保存" onclick="toSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="" type="button" class="btn btn-warning" value="返回列表" onclick="goBackList();"/></li>
	    		</ul>
    		</form>
		
    		
</c:if>
	    </div>
	</div>
</body>


</html>