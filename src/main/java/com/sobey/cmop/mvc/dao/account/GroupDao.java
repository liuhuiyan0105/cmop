package com.sobey.cmop.mvc.dao.account;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.sobey.cmop.mvc.entity.Group;

/**
 * 权限组对象的Dao interface.
 * 
 */
public interface GroupDao extends PagingAndSortingRepository<Group, Integer> {
	Group findByName(String name);
}
