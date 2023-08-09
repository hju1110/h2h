package dao;

import static db.JdbcUtil.*;
import java.sql.*;
import java.util.*;
import vo.*;

public class CartProcDao {
// ��ٱ��� ���� �۾�(��ٱ��Ͽ� ���, ���� ����, ����)���� ó���ϴ� �޼ҵ� 
	private static CartProcDao cartProcDao;
	private Connection conn;
	private CartProcDao() {}		
	
	public static CartProcDao getInstance() {
		if (cartProcDao == null) cartProcDao = new CartProcDao();		
		return cartProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int cartInsert(OrderCart oc) {
	// ����ڰ� ������ ��ǰ (�ɼ�, ���� ����)�� ��ٱ��Ͽ� ��� �޼ҵ� 
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select oc_idx from t_order_cart where mi_id = '" + oc.getMi_id() + "'" +
					" and pi_id = '" + oc.getPi_id()+ "' and ps_idx = " + oc.getPs_idx();
			//System.out.println(sql);
			rs = stmt.executeQuery(sql);
			if (rs.next()) {		//  ������ �ɼ��� ���� ��ǰ�� �̹� ��ٱ��Ͽ� ���� ���  
				sql = "update t_order_cart set oc_cnt = oc_cnt + " + oc.getOc_cnt() + " where oc_idx = " + rs.getInt("oc_idx");				
			} else {				// ó�� ��ٱ��Ͽ� ��� ��ǰ�� ��� 
				sql = "insert into t_order_cart(mi_id, pi_id, ps_idx, oc_cnt) values ('"+oc.getMi_id()+"', '"+oc.getPi_id()+"',"+
			" " + oc.getPs_idx() + ", " + oc.getOc_cnt() + ") ";
				
			}
			//System.out.println(sql);
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("CartProcDao Ŭ������ cartInsert() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return result;
	}

	public ArrayList<OrderCart> getCartList(String miid) {
	// ���� �α����� ȸ���� ��ٱ��Ͽ��� ������ ��ǰ �������� ��� ����Ʈ�� �����ϴ� �޼ҵ�
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<OrderCart> cartList = new ArrayList<OrderCart>();
		OrderCart oc = null;
		
		try {
			ProductProcDao ppd = ProductProcDao.getInstance();
			ppd.setConnection(conn);
			// �۾��� �Ҽ��ְ� setConnection ��� �����شٰ� ����
			stmt = conn.createStatement();
			String sql = "select a.*,  b.pi_name, b.pi_img1, if(b.pi_dc > 0, round((1 - b.pi_dc) * b.pi_price), b.pi_price) price " + 
					"from t_order_cart a, t_product_info b " + 
					"where a.pi_id = b.pi_id and b.pi_isview = 'y' and mi_id = '" + miid + "' " + 
					" order by a.pi_id, a.ps_idx ";
			//System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				oc = new OrderCart();
				oc.setOc_idx(rs.getInt("oc_idx"));
				oc.setMi_id(rs.getString("mi_id"));
				oc.setPi_id(rs.getString("pi_id"));
				oc.setPs_idx(rs.getInt("ps_idx"));
				oc.setOc_cnt(rs.getInt("oc_cnt"));
				oc.setOc_date(rs.getString("oc_date"));				
				oc.setPi_img1(rs.getString("pi_img1"));
				oc.setPi_name(rs.getString("pi_name"));
				oc.setPi_price(rs.getInt("price"));
				oc.setStockList(ppd.getStockList(oc.getPi_id()));
				// ���� ��ǰ�� �ɼ� �� ��� ����� ProductProcDaoŬ������  getStockList()�޼ҵ�� �۾� 
				cartList.add(oc);
			}
			
		} catch(Exception e) {
			System.out.println("CartProcDao Ŭ������ getCartList() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}				
		return cartList;
	}

	public int cartDelete(String where) {
	// ������ ��ǰ(��)�� ��ٱ��Ͽ��� �����ϴ� �޼ҵ� 
		int result = 0;
		Statement stmt = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "DELETE FROM t_order_cart " + where;	
			//System.out.println(sql);
			result = stmt.executeUpdate(sql);
		}catch(Exception e) {
			System.out.println("CartProcDao Ŭ������ cartDelete() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}


	public int cartUpdate(OrderCart oc) {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "";
			
			if (oc.getOc_cnt() == 0) {	// �ɼ� ������ ��� 
				sql = "select oc_idx, oc_cnt from t_order_cart where mi_id = '" + oc.getMi_id() + "' and ps_idx = " + oc.getPs_idx();
				// �����Ϸ��� �ɼǰ� ������ �ɼ��� ��ǰ�� ��ٱ��Ͽ� �̹� �����ϴ��� ���θ� �˻��� ����  
				//System.out.println(sql);
				rs = stmt.executeQuery(sql);
				if (rs.next()) {
				// �����Ϸ��� �ɼǰ� ������ �ɼ��� ��ǰ�� ��ٱ��Ͽ� �̹� �����ϴ� ���	
				// ���� ��ǰ�� ������ �߰��� �� ����	
					
					int idx = rs.getInt("oc_idx");
					
					sql = "update t_order_cart set  ps_idx = " + oc.getPs_idx() + ", " +
						" oc_cnt = oc_cnt + " + rs.getInt("oc_cnt") + " where mi_id = '" + oc.getMi_id() +
						"' and oc_idx = " + oc.getOc_idx();	
					// �ɼ� ���� �� ������ �ɼ��� ���� ��ǰ ������ �� ��ǰ�� �߰��ϴ� ����
					//System.out.println(sql);
					result = stmt.executeUpdate(sql);					
					
					sql = "delete from t_order_cart where oc_idx = " + idx;
					// ������ �ɼ��� ���� ��ǰ�� ��ٱ��Ͽ��� �����ϴ� ���� 
					
				} else {
				// �����Ϸ��� �ɼǰ� ������ �ɼ��� ��ǰ�� ��ٱ��Ͽ� ���� ���
				// �ش� ��ǰ�� �ɼǸ� ���� 
					sql = "update t_order_cart set  ps_idx = " + oc.getPs_idx() + " where mi_id = '" + oc.getMi_id() +
						"' and oc_idx = " + oc.getOc_idx();	
				}			
				close(rs);				
			} else {					// ���� ������ ��� 
				sql ="update t_order_cart set  oc_cnt = " + oc.getOc_cnt() + " where mi_id = '" + oc.getMi_id() +
					"' and oc_idx = " + oc.getOc_idx();	
			}
			//System.out.println(sql);
			result = stmt.executeUpdate(sql);
									
		} catch(Exception e) {
			System.out.println("CartProcDao Ŭ������ cartUpdate() �޼ҵ� ����");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
}

