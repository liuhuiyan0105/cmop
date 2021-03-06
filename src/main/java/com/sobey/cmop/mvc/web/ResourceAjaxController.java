package com.sobey.cmop.mvc.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sobey.cmop.mvc.comm.BaseController;
import com.sobey.cmop.mvc.entity.ToJson.ComputeJson;
import com.sobey.cmop.mvc.entity.ToJson.CpJson;
import com.sobey.cmop.mvc.entity.ToJson.DnsJson;
import com.sobey.cmop.mvc.entity.ToJson.EipJson;
import com.sobey.cmop.mvc.entity.ToJson.ElbJson;
import com.sobey.cmop.mvc.entity.ToJson.MdnJson;
import com.sobey.cmop.mvc.entity.ToJson.MonitorComputeJson;
import com.sobey.cmop.mvc.entity.ToJson.MonitorElbJson;
import com.sobey.cmop.mvc.entity.ToJson.StorageJson;

/**
 * 页面AJAX操作Resource相关的 Controller, 区分申请中的资源和审批通过的资源,并将其进行二次封装以方便页面的取值.
 * 
 * @author liukai
 * 
 */
@Controller
@RequestMapping(value = "/ajax")
public class ResourceAjaxController extends BaseController {

	/**
	 * Ajax请求根据computeId获得compute的对象
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "getCompute")
	public @ResponseBody
	ComputeJson getCompute(@RequestParam(value = "id") Integer id) {
		return comm.resourcesJsonService.convertComputeJsonToComputeItem(comm.computeService
				.getComputeItem(comm.resourcesService.getResources(id).getServiceId()));
	}

	/**
	 * Ajax请求根据resourcesId获得StorageJson的对象
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "getStorage")
	public @ResponseBody
	StorageJson getStorage(@RequestParam(value = "id") Integer id) {
		return comm.resourcesJsonService.convertStorageJsonToComputeItem(comm.es3Service
				.getStorageItem(comm.resourcesService.getResources(id).getServiceId()));
	}

	/**
	 * Ajax请求根据resourcesId获得ElbJson的对象
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "getElb")
	public @ResponseBody
	ElbJson getElb(@RequestParam(value = "id") Integer id) {
		return comm.resourcesJsonService.convertElbJsonToNetworkElbItem(comm.elbService
				.getNetworkElbItem(comm.resourcesService.getResources(id).getServiceId()));
	}

	/**
	 * Ajax请求根据resourcesId获得EipJson的对象
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "getEip")
	public @ResponseBody
	EipJson getEip(@RequestParam(value = "id") Integer id) {
		return comm.resourcesJsonService.convertEipJsonToNetworkEipItem(comm.eipService
				.getNetworkEipItem(comm.resourcesService.getResources(id).getServiceId()));
	}

	/**
	 * Ajax请求根据resourcesId获得DnsJson的对象
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "getDns")
	public @ResponseBody
	DnsJson getDns(@RequestParam(value = "id") Integer id) {
		return comm.resourcesJsonService.convertDnsJsonToNetworkDnsItem(comm.dnsService
				.getNetworkDnsItem(comm.resourcesService.getResources(id).getServiceId()));
	}

	/**
	 * Ajax请求根据resourcesId获得MonitorElbJson的对象
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "getmonitorElb")
	public @ResponseBody
	MonitorElbJson getmonitorElb(@RequestParam(value = "id") Integer id) {
		return comm.resourcesJsonService.convertMonitorElbJsonToMonitorElb(comm.monitorElbServcie
				.getMonitorElb(comm.resourcesService.getResources(id).getServiceId()));
	}

	/**
	 * Ajax请求根据resourcesId获得MonitorElbJson的对象
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "getmonitorCompute")
	public @ResponseBody
	MonitorComputeJson getmonitorCompute(@RequestParam(value = "id") Integer id) {
		return comm.resourcesJsonService.convertMonitorComputeJsonToMonitorCompute(comm.monitorComputeServcie
				.getMonitorCompute(comm.resourcesService.getResources(id).getServiceId()));
	}

	/**
	 * Ajax请求根据resourcesId获得MonitorElbJson的对象
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "getMdn")
	public @ResponseBody
	MdnJson getMdn(@RequestParam(value = "id") Integer id) {
		return comm.resourcesJsonService.convertMdnJsonToMdn(comm.mdnService.getMdnItem(comm.resourcesService
				.getResources(id).getServiceId()));
	}

	/**
	 * Ajax请求根据resourcesId获得CpJson的对象
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "getCP")
	public @ResponseBody
	CpJson getCP(@RequestParam(value = "id") Integer id) {
		return comm.resourcesJsonService.convertCpJsonToCpItem(comm.cpService.getCpItem((comm.resourcesService
				.getResources(id).getServiceId())));
	}
}
