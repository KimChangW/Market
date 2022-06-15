package market.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import market.model.CategoryDTO;
import market.model.FollowDTO;
import market.model.Order_productDTO;
import market.model.ProductDTO;
import market.model.Product_imgDTO;
import market.model.ShopDTO;

@Repository
public class ProductDAOImpl implements ProductDAO {
	@Autowired
	private SqlSessionTemplate sst;
	
	public List<ProductDTO> getShopNo(){
		return sst.selectList("productns.getShopNo");
	}

	public List<ProductDTO> listMain(ProductDTO product){
		return sst.selectList("productns.listMain", product);
	}
	
	public List<ProductDTO> list(ProductDTO product){
		return sst.selectList("productns.list", product);
	}
	
	public List<ProductDTO> mlist(ProductDTO product){
		return sst.selectList("productns.mlist", product);
	}

	public int getTotalMain(ProductDTO product) {
		return sst.selectOne("productns.getTotalMain", product);
	}
	
	public int getTotal(ProductDTO product) {
		return sst.selectOne("productns.getTotal", product);
	}
	
	public int mgetTotal(ProductDTO product) {
		return sst.selectOne("productns.mgetTotal", product);
	}
	
	public int insert(ProductDTO product) {
		return sst.insert("productns.insert", product);
	}

	public ProductDTO select(int p_no) {
		return sst.selectOne("productns.select", p_no);
	}
	
	public void selectUpdate(int p_no) {
		sst.update("productns.selectUpdate", p_no);
	}
	
	public int update(ProductDTO product) {
		return sst.update("productns.update", product);
	}
	
	public int delete(int p_no) {
		return sst.update("productns.delete", p_no);
	}
	
	public int stop(int p_no) {
		return sst.update("productns.stop", p_no);
	}

	public int getMaxNum() {
		return sst.selectOne("productns.getMaxNum");
	}
	
	public List<CategoryDTO> listCategory(ProductDTO product) {
		return sst.selectList("productns.listCategory", product);
	}
	
	public List<CategoryDTO> listCateNo(){
		return sst.selectList("productns.listCateNo");
	}

	public int insertImg(Product_imgDTO product_img) {
		return sst.insert("productns.insertImg", product_img);
	}

	public List<Product_imgDTO> listImg(int p_no) {
		return sst.selectList("productns.listImg", p_no);
	}	
	
	public ShopDTO getShopInfo(ProductDTO product) {
		return sst.selectOne("productns.getShopInfo", product);
	}

	@Override
	public List<FollowDTO> getFollowShopNo(int s_no) {
		return sst.selectList("productns.getFollowShopNo", s_no);
	}
	
	public List<Order_productDTO> getGroup(ProductDTO pdto){
		return sst.selectList("productns.getGroup", pdto);
	}
	
	@Override
	public int updateGroupOrder(Order_productDTO opdto) {
		return sst.update("productns.updateGroupOrder", opdto);
	}
}
