package dao;

import static db.JdbcUtil.*;
import java.time.*;
import java.sql.*;
import java.util.*;
import vo.*;

public class OrderProcDao {
// 주문 관련 작업 (장바구니 ,등록, 변경)들을 처리하는 클래스 
	private static OrderProcDao orderProcDao;
	private Connection conn;
	private OrderProcDao() {}		
	
	public static OrderProcDao getInstance() {
		if (orderProcDao == null) orderProcDao = new OrderProcDao();		
		return orderProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public ArrayList<OrderCart> getBuyList(String kind, String sql) {
	// 주문 폼에서 보여줄 구매할 상품목록을  ArrayList<OrderCart>형으로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<OrderCart> pdtList = new ArrayList<OrderCart>();
		OrderCart oc = null;
		 
		try {
			stmt = conn.createStatement();	
			//System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				oc = new OrderCart();
				if (kind.equals("c"))  oc.setOc_idx(rs.getInt("oc_idx"));
				// 장바구니를 통한 구매일 경우에만 장바구니 인덱스를 추가 저장함 
				else 				   oc.setOc_idx(0);
				// 바로 구매일 ㄱ9ㅕㅇ우 기본값으로 채워줌 
				oc.setPi_id(rs.getString("pi_id"));
				oc.setPi_img1(rs.getString("pi_img1"));
				oc.setPi_name(rs.getString("pi_name"));
				oc.setPi_price(rs.getInt("price"));
				oc.setOc_cnt(rs.getInt("cnt"));
				oc.setPs_size(rs.getInt("ps_size"));			
				pdtList.add(oc);
			}
		} catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 getBuyList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}		
		return pdtList;
	}

	public ArrayList<MemberAddr> getAddrList(String miid) {
	// 주문 폼에서 보여줄 현재 로그인한 회원의 주소목록을 ArrayList<MemberAddr> 형 리스트로 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<MemberAddr> addrList = new ArrayList<MemberAddr>();
		MemberAddr ma = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_member_addr where mi_id = '" + miid + "' order by ma_basic desc ";
			//System.out.println(sql);
			
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				ma = new MemberAddr();
				ma.setMa_idx(rs.getInt("ma_idx"));
				ma.setMa_name(rs.getString("ma_name"));
				ma.setMa_rname(rs.getString("ma_rname"));
				ma.setMa_phone(rs.getString("ma_phone"));
				ma.setMa_zip(rs.getString("ma_zip"));
				ma.setMa_addr1(rs.getString("ma_addr1"));
				ma.setMa_addr2(rs.getString("ma_addr2"));	
				ma.setMa_basic(rs.getString("ma_basic"));
				addrList.add(ma);
			}
		}catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 getAddrList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}	
		
		return addrList;
	}
	
	private String getOrderId() {
	// 새로운 주문번호(yymmdd + 랜덤영문2자리 + 일련번호4자리(1001) + 랜덤영문2자리)를 생성하여 리턴하는 메소드 	
		Statement stmt = null;
		ResultSet rs = null;
		String oi_id = null;
		
		try {
			stmt = conn.createStatement();
			LocalDate today = LocalDate.now();	// yyyy-mm-dd 이렇게 나옴 
			String td = (today + "").substring(2).replace("-", ""); // yymmdd
			
			String alpha = "ABCDEFGHIJkLMNOPQRSTUVWXYZ";
			Random rnd = new Random();
			String eng1 = alpha.charAt(rnd.nextInt(26)) + "";
			eng1 += alpha.charAt(rnd.nextInt(26)) + "";	
			String eng2 = alpha.charAt(rnd.nextInt(26)) + "";
			eng2 += alpha.charAt(rnd.nextInt(26)) + "";			
						
			String sql = "select mid(oi_id, 9, 4) seq from t_order_info where left(oi_id, 6) = '" + td + "' " +
			" order by oi_date desc limit 0, 1";
			
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				int num = Integer.parseInt(rs.getString("seq")) + 1;
				oi_id = td + eng1 + num + eng1; 
			} else {		// 오늘 첫 구매일 경우 
				oi_id = td + eng1 + "1001" + eng2; 				
			}
			
		}catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 getOrderId() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return oi_id;
		
	}
	
	public String orderInsert(String kind, OrderInfo oi, String ocidxs) {
	// 주문처리를 하는 메소드(장바구니나 바로 구매를 통한 주문)
		Statement stmt = null;
		ResultSet rs = null;
		String oi_id = getOrderId();
		String result = oi_id + ",";
		int rcount = 0, target = 0;
		//rcount : 실제 쿼리 실행결과로 적용되는 레코드 개수를 누적 저장할 변수
		// target : insert, update, delete 등의 쿼리 실행횟루로 적용되어야 할 레코드의 총 개수 
		
		
		try {
			stmt = conn.createStatement();
			
			// t_order_info 테이블에 사용할 insert문
						
			String sql = "insert into t_order_info values ('"+oi_id+"', '" + oi.getMi_id() + "', "+
			"'"+oi.getOi_name()+"', '"+oi.getOi_phone()+"', '"+oi.getOi_zip()+"', '"+oi.getOi_addr1()+"',"+
			"'"+oi.getOi_addr2()+"', '"+oi.getOi_memo()+"', '" + oi.getOi_payment() + "', '" + oi.getOi_pay() + "', 0, 0, null,"+
			" '"+oi.getOi_status()+"', now())";
			//System.out.println(sql);
			target++; 	rcount = stmt.executeUpdate(sql);
			
			if (kind.equals("c")) {	// 장바구니를 통한 구매일 경우
				//장바구니에서 t_order_detail 테이블에 insert 할 상품 정보를 추출;
				sql = "select a.pi_id, a.ps_idx, a.oc_cnt, b.pi_name, b.pi_img1, c.ps_size, "+ 
				" if(b.pi_dc > 0, round((1 - b.pi_dc) * b.pi_price), b.pi_price) price " + 
				" from t_order_cart a, t_product_info b, t_product_stock c " + 
				" where a.pi_id = b.pi_id and a.ps_idx = c.ps_idx and a.mi_id = '" + oi.getMi_id() + "' and (";
								
				String delWhere = " where mi_id = '" + oi.getMi_id() + "' and (";
				String[] arr = ocidxs.split(",");			// 장바구니 테이블의 인덱스 번호들로 배열 생성 
				for (int i = 0; i < arr.length; i++) {
					if (i == 0) {
						sql += "a.oc_idx = " + arr[i];
						delWhere += "a.oc_idx = " + arr[i];
					} else {
						sql += " or a.oc_idx = " + arr[i];
						delWhere += " or a.oc_idx = " + arr[i];
					}
				}
				sql += ")";		delWhere += ")";
				//System.out.println(sql);
				rs = stmt.executeQuery(sql);
				if (rs.next()) {		// 장바구니에 검색할 상품정보가 있으면
					do {
						Statement stmt2 = conn.createStatement();
						
						// t_order_detail 테이블에 사용할 insert 문
						sql = "insert into t_order_detail value (null, '"+oi_id+"', '" + rs.getString("pi_id") + "'," +
						" '" + rs.getInt("ps_idx") + "', '" + rs.getInt("oc_cnt") + "', '" +rs.getInt("price")+ "' , " +
						" '" + rs.getString("pi_name") + "', '" +rs.getString("pi_img1") + "', '" + rs.getInt("ps_size") + "')";
						//System.out.println(sql);
						target++; 	rcount = stmt2.executeUpdate(sql);
						
						// t_product_info 테이블의 판매수 증가 update문
						sql = "update t_product_info set pi_sale = pi_sale + " + rs.getInt("oc_cnt") + 
								" where pi_id = '" + rs.getString("pi_id") + "' ";
						//System.out.println(sql);
						target++; 	rcount = stmt2.executeUpdate(sql);
						
						// t_product_stock 테이블의 판매 및 재고 변경 update 문 
						sql = "update t_product_stock set ps_stock = ps_stock - " + rs.getInt("oc_cnt") + 
						", ps_sale = ps_sale + " + rs.getInt("oc_cnt") + " where ps_idx = " + rs.getInt("ps_idx");
						//System.out.println(sql);
						target++; 	rcount = stmt2.executeUpdate(sql);
						close(stmt2);
						
					} while(rs.next());
					close(rs);					
					
					// t_order_cart 테이블에 구매 후 삭제 delete문
					sql = "delete from t_order_cart " + delWhere;
					// System.out.println(sql);
					stmt.executeUpdate(sql);
					// 실행시 문제가 발생해도 구매와는 별도이므로 rcount에 누적시키지 않음 
				} else {				// 장바구니에 구매할 상품정보가 없으면
					return result + "1,4";
				}
		
				
			} else {				// 바로 구매일 경우 
				
			}
			
			if (oi.getOi_spoint() > 0) {		// 적립되는 포인트가 있으면
				// 회원의 포유 포인트 update 실행 
				sql = "update t_member_info set mi_point = mi_point + " + oi.getOi_spoint() + 
				" where mi_id = '" + oi.getMi_id() + "' ";
				// System.out.println(sql);
				target++; 	rcount = stmt.executeUpdate(sql);
				
				//회원의 포틴트 사용내역 insert 문
				sql = "insert into t_member_point (mi_id, mp_point, mp_desc, mp_detail) " + 
				" values ('" + oi.getMi_id() + "', " + oi.getOi_spoint() + ", '상품구매', '" + oi_id + "')";
				// System.out.println(sql);
				target++; 	rcount = stmt.executeUpdate(sql);
				
			}
			

			if (oi.getOi_spoint() > 0) {		// 사용되는 포인트가 있으면
				// 회원의 포유 포인트 update 실행 
				sql = "update t_member_info set mi_point = mi_point - " + oi.getOi_upoint() + 
				" where mi_id = '" + oi.getMi_id() + "' ";
				// System.out.println(sql);
				target++; 	rcount = stmt.executeUpdate(sql);
				
				//회원의 포틴트 사용내역 insert 문
				sql = "insert into t_member_point (mi_id, mp_su, mp_point, mp_desc, mp_detail) " + 
				" values ('" + oi.getMi_id() + "', 'u', -" + oi.getOi_upoint() + ", '상품구매', '" + oi_id + "')";
				// System.out.println(sql);
				target++; 	rcount = stmt.executeUpdate(sql);						
			}
			
		}catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 orderInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}	
		
		return result + rcount + "," + target;
		
	}

	public OrderInfo getOrderInfo(String miid, String oiid) {
	// 받아온 회원아이디와 주문아이디에 해당하는 주문정보들을 OrderInfo형 인스턴스로 리턴하는 메소드 
		Statement stmt = null;
		ResultSet rs = null;
		OrderInfo oi = null;
		ArrayList<OrderDetail> detailList = new ArrayList<OrderDetail>();
		
		try {
			stmt = conn.createStatement();
			String sql = "select a.*, b.*, c.pi_isview " + 
					"from t_order_info a, t_order_detail b,  t_product_info c " + 
					" where a.oi_id = b.oi_id and b.pi_id = c.pi_id " + 
					" and a.mi_id = '" + miid + "' and a.oi_id = '" + oiid + "' order by c.pi_id, b.od_size";
			//System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				// 오더인포 데이터
				do {
				// 오더디테일	
				} while(rs.next());
			}
			
			
		} catch(Exception e) {
			System.out.println("OrderProcDao 클래스의 getOrderInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		
		return oi;
	}
		
}
