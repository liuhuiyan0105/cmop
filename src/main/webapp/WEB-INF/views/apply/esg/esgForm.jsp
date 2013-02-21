<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/layouts/taglib.jsp"%>

<html>
<head>

	<title>安全组ESG管理</title>

	<script>
		$(document).ready(function() {
			
			$("ul#navbar li#apply").addClass("active");
			
			$("#description").focus();
			
			
			/*禁用回车提交form表单.*/
			$("#inputForm").keypress(function(e) {
				if (e.which == 13) {return false;}
			});
			
			$("#inputForm").validate({
				errorClass: "help-inline",
				errorElement: "span",
				highlight: function(element, errorClass, validClass) {
	
					$(element).closest('.control-group').addClass('error');
				},
				unhighlight: function(element, errorClass, validClass) {
					$(element).closest('.control-group').removeClass('error');
				}
	
			});
			
			
			/*点击页面"生成规则"按钮时,根据前面的协议,端口范围,访问源生成alert的资源.*/
			$(document).on("click", "#createBtn", function() {
	
				if (!$("#inputForm").valid()) {
					return false;
				}
	
				var protocol = $("#protocol").val();
				var portRange = $("#portRange").val();
				var visitSource = $("#visitSource").val();
	
				if (!$("#inputForm").valid()) {
					return false;
				}
				
	
				//如果重复,则删除重复的项.
				
				$("#resourcesDIV div.resources").each(function() {
					var $this = $(this);
					$this.find("input[name='protocols']").val() == protocol && $this.find("input[name='portRanges']").val() == portRange && $this.find("input[name='visitSources']").val() == visitSource && $this.remove();
				});
				
	
				//拼装资源alert信息
				
				var html = '<div class="resources alert alert-block alert-info fade in">';
				html += '<button data-dismiss="alert" class="close" type="button">×</button>';
				html += '<div class="row">';
				html += '<span class="span1">' + protocol + '</span>';
				html += '<span class="span2">' + portRange + '</span>';
				html += '<span class="span3">' + visitSource + '</span>';
				html += '<input type="hidden" value="' + protocol + '" name="protocols">';
				html += '<input type="hidden" value="' + portRange + '" name="portRanges">';
				html += '<input type="hidden" value="' + visitSource + '" name="visitSources">';
				html += '</div>';
				html += '</div>';
	
				$("#resourcesDIV").append(html);
	
			});
			
			
			/*根据alert中的资源信息,组成汇总信息.*/
			$(".nextStep").click(function() {
	
				var html = '<dl class="dl-horizontal">';
				html += ' <dt>安全组描述</dt>';
				html += '<dd>' + $("#description").val() + '</dd>';
	
				$("#resourcesDIV div.resources").each(function() {
					
					var $this = $(this);
	
					var protocol = $this.find("input[name='protocols']").val();
					var portRange = $this.find("input[name='portRanges']").val();
					var visitSource = $this.find("input[name='visitSources']").val();
	
					html += '<hr>';
					html += '<dt>协议</dt>';
					html += '<dd>' + protocol + '</dd>';
					html += '<dt>端口范围</dt>';
					html += '<dd>' + portRange + '</dd>';
					html += '<dt>访问源</dt>';
					html += '<dd>' + visitSource + '</dd>';
	
				});
	
				html += '</dl>';
	
				$("#resourcesList").append(html);
			});
			 
			
		});
	</script>
	
</head>

<body>
	
	<style>body{background-color: #f5f5f5;}</style>

	<form id="inputForm" action="." method="post" class="form-horizontal input-form">
	
		<input type="hidden" name="id" value="${esg.id}">
		
		<fieldset>
			<legend><small>
				<c:choose>
					<c:when test="${not empty esg }">修改安全组ESG </c:when>
					<c:otherwise>创建安全组ESG</c:otherwise>
				</c:choose>
			</small></legend>
			
			<!-- Step.1 -->
			<div class="step">
				
				<!-- 错误提示 -->
				<div id="message" class="alert alert-error fade"><span>错误信息</span></div>
				
				<c:if test="${not empty esg}">
					<div class="control-group">
						<label class="control-label" for="identifier">标题</label>
						<div class="controls">
							<p class="help-inline plain-text">${esg.identifier}</p>
						</div>
					</div>
				</c:if>
				
				<div class="control-group">
					<label class="control-label" for="description">安全组的描述</label>
					<div class="controls">
						<input type="text" id="description" name="description" class="required" maxlength="45" value="${esg.description}" placeholder="...安全组的描述">
					</div>
				</div>
				
			 	<div class="control-group">
					<label class="control-label" for="protocol">协议</label>
					<div class="controls">
						<select id="protocol" class="required">
							<c:forEach var="map" items="${esgProtocolMap}">
								<option value="${map.key}">${map.value }</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="portRange">端口范围</label>
					<div class="controls">
						<input type="text" id="portRange" placeholder="80 or 8080/65535">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="visitSource">访问源</label>
					<div class="controls">
						<input type="text" id="visitSource" placeholder="192.168.0.1 or 192.168.0.1/10">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="createBtn"></label>
					<div class="controls">
						<input id="createBtn" type="button" class="btn" value="生成规则">
					</div>
				</div>
				
				<!-- 生成的资源 -->
				<div id="resourcesDIV"></div>
				
				<div class="form-actions">
					<input class="btn" type="button" value="返回" onclick="history.back()">
					<input class="btn btn-primary nextStep" type="button" value="下一步">
				</div>
			
			</div><!-- Step.1 End -->
			
			<!-- Step.2 -->
			<div class="step">
				 
				 <!-- 汇总信息 -->
				 <div id="resourcesList"></div>
				 
				<div class="form-actions">
					<input class="btn backStep" type="button" value="返回">
					<input class="btn btn-primary" type="submit" value="提交">
				</div>
			
			</div><!-- Step.2 End -->
			
		</fieldset>
		
	</form>
	
</body>
</html>