package svc;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import dao.*;
import vo.*;

public class OrderProcSvc {
	private OrderProcDao orderProcDao;

	public void setOrderProcDao(OrderProcDao orderProcDao) {
		this.orderProcDao = orderProcDao;
	}

	public List<OrderCart> getBuyList(String string) {
		List<OrderCart> pdtList = orderProcDao.getBuyList(string);
		return pdtList;
	}

	public List<MemberAddr> getAddrList(String miid) {
		List<MemberAddr> addrList = orderProcDao.getAddrList(miid);
		return addrList;
	}

	@Transactional(rollbackFor = SQLException.class)
	public int orderProcIn(OrderProcInCtrl oi, String pi_id) {
		int rcnt = orderProcDao.orderProcIn(oi, pi_id);
		return rcnt;
	}
	
	
}
