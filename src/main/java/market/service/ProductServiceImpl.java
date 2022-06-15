package market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import market.dao.ProductDAO;
import market.model.CategoryDTO;
import market.model.FollowDTO;
import market.model.Order_productDTO;
import market.model.ProductDTO;
import market.model.Product_imgDTO;
import market.model.ShopDTO;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductDAO pd;

	public List<ProductDTO> getShopNo(){
		return pd.getShopNo();
	}

	public List<ProductDTO> listMain(ProductDTO product){
		return pd.listMain(product);
	}
	
	public List<ProductDTO> list(ProductDTO product){
		return pd.list(product);
	}
	
	public List<ProductDTO> mlist(ProductDTO product){
		return pd.mlist(product);
	}

	public int getTotalMain(ProductDTO product) {
		return pd.getTotalMain(product);
	}
	
	public int getTotal(ProductDTO product) {
		return pd.getTotal(product);
	}
	
	public int mgetTotal(ProductDTO product) {
		return pd.mgetTotal(product);
	}
	
	public int insert(ProductDTO product) {
		return pd.insert(product);
	}
	
	public ProductDTO select(int p_no) {
		return pd.select(p_no);
	}
	
	public void selectUpdate(int p_no) {
		pd.selectUpdate(p_no);
	}
	
	public int update(ProductDTO product) {
		return pd.update(product);
	}
	
	public int delete(int p_no) {
		return pd.delete(p_no);
	}
	
	public int stop(int p_no) {
		return pd.stop(p_no);
	}

	public int getMaxNum() {
		return pd.getMaxNum();
	}
	
	public List<CategoryDTO> listCategory(ProductDTO product) {
		return pd.listCategory(product);
	}
	
	public List<CategoryDTO> listCateNo(){
		return pd.listCateNo();
	}

	public int insertImg(Product_imgDTO product_img) {
		return pd.insertImg(product_img);
	}

	public List<Product_imgDTO> listImg(int p_no) {
		return pd.listImg(p_no);
	}
	
	public ShopDTO getShopInfo(ProductDTO product) {
		return pd.getShopInfo(product);
	}

	@Override
	public List<FollowDTO> getFollowShopNo(int s_no) {
		return pd.getFollowShopNo(s_no);
	}
	
	public List<Order_productDTO> getGroup(ProductDTO pdto){
		return pd.getGroup(pdto);
	}
	
	public int updateGroupOrder(Order_productDTO opdto) {
		return pd.updateGroupOrder(opdto);
	}
	
	
}
