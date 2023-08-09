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

	public List<ProductInfo> getProductList(int cpage, int psize, String orderBy) {
		List<ProductInfo> productList = productProcDao.getProductList(cpage, psize, orderBy);
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
}
