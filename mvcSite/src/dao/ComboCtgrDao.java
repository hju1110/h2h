package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import vo.FreeList;
import vo.ProductCtgrBig;
import vo.ProductCtgrSmall;


public class ComboCtgrDao {
	// �����Խ��� ���� ���� �۾�(��� ��� ���� ����)�� ��� ó���ϴ� Ŭ���� 
		private static ComboCtgrDao comboCtgrDao;
		private Connection conn;
		private ComboCtgrDao() {}		
		
		public static ComboCtgrDao getInstance() {
			if (comboCtgrDao == null) comboCtgrDao = new ComboCtgrDao();
			return comboCtgrDao;
		}
		
		public void setConnection(Connection conn) {
			this.conn = conn;
		}

		public ArrayList<ProductCtgrBig> getBigList() {
		// ��ǰ ��з� �����	ArrayList<ProductCtgrBig> ������ �����ϴ� �޼ҵ� 
			Statement stmt = null;
			ResultSet rs = null;
			ArrayList<ProductCtgrBig> bigList = new ArrayList<ProductCtgrBig>();
			ProductCtgrBig ctgtBig = null;	
			
			try {				
				stmt = conn.createStatement();
				String sql = "select * from t_product_ctgr_big";
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
					ctgtBig = new ProductCtgrBig();
					ctgtBig.setPcb_id(rs.getString("pcb_id"));
					ctgtBig.setPcb_name(rs.getString("pcb_name"));
					bigList.add(ctgtBig);
				}
				
			} catch(Exception e) {
				System.out.println("ComboCtgrDao Ŭ������ getBigList() �޼ҵ� ����");
				e.printStackTrace();
			} finally {
				close(rs);	close(stmt);
			}	
			return bigList;
		}

		public ArrayList<ProductCtgrSmall> getSmallList() {
			Statement stmt = null;
			ResultSet rs = null;
			ArrayList<ProductCtgrSmall> smallList = new ArrayList<ProductCtgrSmall>();
			ProductCtgrSmall ctgtsmall = null;	
			
			try {				
				stmt = conn.createStatement();
				String sql = "select * from t_product_ctgr_small";
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
					ctgtsmall = new ProductCtgrSmall();
					ctgtsmall.setPcb_id(rs.getString("pcb_id"));
					ctgtsmall.setPcs_id(rs.getString("pcs_id"));
					ctgtsmall.setPcs_name(rs.getString("pcs_name"));
					smallList.add(ctgtsmall);
				}
				
			} catch(Exception e) {
				System.out.println("ComboCtgrDao Ŭ������ getSmallList() �޼ҵ� ����");
				e.printStackTrace();
			} finally {
				close(rs);	close(stmt);
			}	
			return smallList;
		}
}

