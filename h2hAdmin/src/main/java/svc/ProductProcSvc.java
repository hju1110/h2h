package svc;


import java.util.ArrayList;
import java.util.List;
import dao.*;
import vo.*;

public class ProductProcSvc {
	private ProductProcDao productProcDao;

	public void setProductProcDao(ProductProcDao productProcDao) {
		this.productProcDao = productProcDao;
	}

	public int getProductCount(String where) {
		int rcnt = productProcDao.getProductCount(where);
		return rcnt;
	}

	public List<ProductInfo> getProductList(int cpage, int psize) {
		List<ProductInfo> productList = productProcDao.getProductList(cpage, psize);
		return productList;
	}

	public int readUpdate(String piid) {
		int result = productProcDao.readUpdate(piid);
		return result;
	}

	public ProductInfo getProductInfo(String piid) {
		ProductInfo pi = productProcDao.getProductInfo(piid);
		
		return pi;
	}

	public int productInsert(ProductInfo pi) {
		int result = productProcDao.productInsert(pi);
		return result;
	}

	public List<ProductInfo> getProductList1(int cpage, int psize) {
		List<ProductInfo> productList = productProcDao.getProductList1(cpage, psize);
		return productList;
	}

	public ProductInfo productUp(String pi_id) {
		ProductInfo pi = productProcDao.productUp(pi_id);
		return pi;
	}

	public int productUpdate(ProductInfo pi) {
		int result = productProcDao.productUpdate(pi);
		return result;
	}	
}
