package svc;

import java.util.ArrayList;
import java.util.List;
import dao.*;
import vo.*;

public class OrderProcSvc {
	private OrderProcDao orderProcDao;

	public void setOrderProcDao(OrderProcDao orderProcDao) {
		this.orderProcDao = orderProcDao;
	}

	public List<OrderCart> getBuyList(String string, int cnt) {
		List<OrderCart> pdtList = orderProcDao.getBuyList(string, cnt);
		return pdtList;
	}

	public List<MemberAddr> getAddrList(String miid) {
		List<MemberAddr> addrList = orderProcDao.getAddrList(miid);
		return addrList;
	}

	public int orderProcIn(OrderProcInCtrl oi, String pi_id, int cnt) {
		int rcnt = orderProcDao.orderProcIn(oi, pi_id, cnt);
		return rcnt;
	}

	public int productLiek(String pi_id) {
		int result = orderProcDao.productLiek(pi_id);
		return result;
		
	}
	
	
}
