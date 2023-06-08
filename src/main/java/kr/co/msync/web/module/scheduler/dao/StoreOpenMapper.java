package kr.co.msync.web.module.scheduler.dao;

import org.springframework.stereotype.Repository;

@Repository
public interface StoreOpenMapper {
	int updateStoreOpen();
	int updateStoreClose();
}