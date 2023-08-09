package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;


public class OrderProcSvc {
	public ArrayList<OrderCart> getBuyList(String kind, String sql) {
		ArrayList<OrderCart> pdtList = new ArrayList<OrderCart>();
				
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		  
		pdtList = orderProcDao.getBuyList(kind, sql);		
		close(conn); 
		
		return pdtList;
	}

	public ArrayList<MemberAddr> getAddrList(String miid) {
		ArrayList<MemberAddr> addrList = new ArrayList<MemberAddr>();
		
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		  
		addrList = orderProcDao.getAddrList(miid);		
		close(conn); 
		
		return addrList;
	}

	public String orderInsert(String kind, OrderInfo oi, String ocidxs) {
		String result = null;
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		  
		result = orderProcDao.orderInsert(kind, oi, ocidxs);	
		// result : 주문번호,적용된 레코드수,적용되어야할 레코드수
		String[] arr = result.split(",");
		if (arr[1].equals(arr[2])) commit(conn);
		// 실제 적용된 레코드 개수와 적용되어야 할 레코드 개수가 같으면
		else 			    rollback(conn); 
		close(conn); 
		
		return result;
	}

	public OrderInfo getOrderInfo(String miid, String oiid) {
		OrderInfo orderInfo = null;
		
		Connection conn = getConnection();
		OrderProcDao orderProcDao = OrderProcDao.getInstance();
		orderProcDao.setConnection(conn);
		  
		orderInfo = orderProcDao.getOrderInfo(miid, oiid);		
		close(conn); 
		
		return orderInfo;
	}
}
