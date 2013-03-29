<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/layouts/taglib.jsp"%>

<html>
<head>

	<title>服务申请</title>

	<script>
		$(document).ready(function() {
			
			$("ul#navbar li#resource").addClass("active"); 
			
			$("#inputForm").validate();
			
		});
	</script>
	
</head>

<body>

	<style>body{background-color: #f5f5f5;}</style>
	

	<form id="inputForm" action="${ctx}/resources/update/mdn/" method="post" class="input-form form-horizontal">
	
		<c:if test="${not empty message}"><div id="message" class="alert alert-success fade in"><button data-dismiss="alert" class="close" type="button">×</button><span>${message}</span></div></c:if>
		
		<input type="hidden" name="id" value="${resources.id }">
		
		<fieldset>
		
			<legend><small>变更MDN</small></legend>
			
			<div class="control-group">
				<label class="control-label" for="serviceTagId">服务标签</label>
				<div class="controls">
					<select id="serviceTagId" name="serviceTagId" class="required">
						<c:forEach var="item" items="${tags}">
							<option value="${item.id }" 
								<c:if test="${item.id == resources.serviceTag.id }">
									selected="selected"
								</c:if>
							>${item.name}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="usedby">运维人</label>
				<div class="controls">
					<select id="usedby" name="usedby" class="required">
						<c:forEach var="map" items="${assigneeMap}">
							<option value="${map.key}" 
								<c:if test="${map.key == resources.usedby }">
									selected="selected"
								</c:if>
							>${map.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="changeDescription">变更描述</label>
				<div class="controls">
					<textarea rows="3" id="changeDescription" name="changeDescription" placeholder="...变更描述"
						maxlength="200" class="required">${change.description}</textarea>
				</div>
			</div>
			
			<hr>
			
			<div class="control-group">
				<label class="control-label" for="title">所属服务申请</label>
				<div class="controls">
					<p class="help-inline plain-text">${mdn.apply.title}</p>
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="identifier">标识符</label>
				<div class="controls">
					<p class="help-inline plain-text">${mdn.identifier}</p>
				</div>
			</div>
				 
			<div class="control-group">
				<label class="control-label" for="coverArea">重点覆盖地域</label>
				<div class="controls">
					<input type="text" id="coverArea" name="coverArea" value="${mdn.coverArea}" class="required">
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="coverIsp">重点覆盖ISP</label>
				<div class="controls">
					<c:forEach var="map" items="${ispTypeMap}">
						<label class="checkbox">
							<input type="checkbox" name="coverIsp" value="${map.key}" 
								<c:forEach var="coverIsp" items="${fn:split(mdn.coverIsp,',')}">
									<c:if test="${map.key == coverIsp }"> checked="checked" </c:if>
						    	</c:forEach>
							class="required">
							<span class="checkboxText ">${map.value}</span>
						</label>
					</c:forEach>
				</div>
			</div>
			
			<dl class="dl-horizontal">
			
				<c:if test="${not empty mdn.mdnVodItems }">
					<br>
					<dt>MDN点播加速</dt>
					<c:forEach var="vod" items="${mdn.mdnVodItems}">
						<dd><em>服务域名</em>&nbsp;&nbsp;${vod.vodDomain}</dd>
						<dd><em>加速服务带宽</em>&nbsp;&nbsp;<c:forEach var="map" items="${bandwidthMap }"><c:if test="${map.key == vod.vodBandwidth }">${map.value }</c:if></c:forEach></dd>
						<dd><em>播放协议选择</em>&nbsp;&nbsp;${vod.vodProtocol}</dd>
						<dd><em>出口带宽</em>&nbsp;&nbsp;${vod.sourceOutBandwidth}</dd>
						<dd><em>Streamer地址</em>&nbsp;&nbsp;${vod.sourceStreamerUrl}
							<span class="pull-right">
								<a href="${ctx}/resources/update/${resources.id}/vod/${vod.id}">变更</a>&nbsp;
							</span>
						</dd>
						<br>
					</c:forEach>
				</c:if>
				
				<c:if test="${not empty mdn.mdnLiveItems }">
					<br>
					<dt>MDN直播</dt>
					<c:forEach var="live" items="${mdn.mdnLiveItems}">
						<dd><em>服务域名</em>&nbsp;&nbsp;${live.liveDomain}</dd>
						<dd><em>加速服务带宽</em>&nbsp;&nbsp;<c:forEach var="map" items="${bandwidthMap }"><c:if test="${map.key == live.liveBandwidth }">${map.value }</c:if></c:forEach></dd>
						<dd><em>播放协议选择</em>&nbsp;&nbsp;${live.liveProtocol}</dd>
						<dd><em>出口带宽</em>&nbsp;&nbsp;${live.bandwidth}</dd>
						<dd><em>频道名称</em>&nbsp;&nbsp;${live.name}</dd>
						<dd><em>频道GUID</em>&nbsp;&nbsp;${live.guid}</dd>
						<dd><em>直播流输出模式</em>&nbsp;&nbsp;<c:forEach var="map" items="${outputModeMap }"><c:if test="${map.key == live.streamOutMode }">${map.value }</c:if></c:forEach></dd>
						<c:choose>
							<c:when test="${live.streamOutMode == 1  }">
								<dd><em>编码器模式</em>&nbsp;&nbsp;<c:forEach var="map" items="${encoderModeMap }"><c:if test="${map.key == live.encoderMode }">${map.value }</c:if></c:forEach></dd>
								<c:choose>
									<c:when test="${live.encoderMode == 1 }">
										<dd><em>HTTP流地址</em>&nbsp;&nbsp;${live.httpUrl}</dd>
										<dd><em>HTTP流混合码率</em>&nbsp;&nbsp;${live.httpBitrate}</dd>
									</c:when>
									<c:otherwise>
										<dd><em>M3U8流地址</em>&nbsp;&nbsp;${live.hlsUrl}</dd>
										<dd><em>M3U8流混合码率</em>&nbsp;&nbsp;${live.hlsBitrate}</dd>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<dd><em>HTTP流地址</em>&nbsp;&nbsp;${live.httpUrl}</dd>
								<dd><em>HTTP流混合码率</em>&nbsp;&nbsp;${live.httpBitrate}</dd>
								
								<dd><em>M3U8流地址</em>&nbsp;&nbsp;${live.hlsUrl}</dd>
								<dd><em>M3U8流混合码率</em>&nbsp;&nbsp;${live.hlsBitrate}</dd>
								
								<dd><em>RTSP流地址</em>&nbsp;&nbsp;${live.rtspUrl}</dd>
								<dd><em>RTSP流混合码率</em>&nbsp;&nbsp;${live.rtspBitrate}</dd>
							</c:otherwise>
						</c:choose>
						<dd>
							<span class="pull-right">
								<a href="${ctx}/resources/update/${resources.id}/live/${live.id}">变更</a>&nbsp;
							</span>
						</dd>
						<br>
					</c:forEach>
				</c:if>
				
			</dl>
			
			<div class="form-actions">
				<a href="${ctx}/resources/" class="btn">返回</a>
				<input class="btn btn-primary" type="submit" value="提交">
			</div>
			
		</fieldset>
		
	</form>
	
</body>
</html>