package market.service;

import java.util.List;

import market.model.CategoryDTO;
import market.model.FollowDTO;
import market.model.Order_productDTO;
import market.model.ProductDTO;
import market.model.Product_imgDTO;
import market.model.ShopDTO;


public interface ProductService {

	List<ProductDTO> getShopNo();
	
	List<ProductDTO> listMain(ProductDTO product);
	
	List<ProductDTO> list(ProductDTO product);
	
	List<ProductDTO> mlist(ProductDTO product);
	
	int getTotalMain(ProductDTO product);
	
	int getTotal(ProductDTO product);
	
	int mgetTotal(ProductDTO product);
	
	int insert(ProductDTO product);
	
	ProductDTO select(int p_no);
	
	void selectUpdate(int p_no);
	
	int update(ProductDTO product);
	
	int delete(int p_no);
	
	int stop(int p_no);
	
	int getMaxNum();

	List<CategoryDTO> listCategory(ProductDTO product);
	
	List<CategoryDTO> listCateNo();

	int insertImg(Product_imgDTO product_img);
	
	List<Product_imgDTO> listImg(int p_no);
	
	ShopDTO getShopInfo(ProductDTO product);
	
	List<FollowDTO> getFollowShopNo(int s_no);
	
	List<Order_productDTO> getGroup(ProductDTO pdto);
	
	int updateGroupOrder(Order_productDTO opdto);
}
