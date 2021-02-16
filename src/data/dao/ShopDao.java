package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import data.dto.CartDto;
import data.dto.ShopDto;
import oracle.db.DbConnect;

public class ShopDao {
	DbConnect db=new DbConnect();
	
	//insert
	public void insertShop(ShopDto dto)
	{
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		Statement stmt=null;
		
		//String sql="insert into shop values (seq_mini.nextval,'"+dto.getCategory()+"','"+dto.getSangpum()+"','"+dto.getPhoto()+"',"+dto.getPrice()+",'"+dto.getColor()+"','"+dto.getIpgoday()+"'";
		
		String sql="insert into shop values (seq_mini.nextval,"
				+ "?,?,?,?,?,?)";
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, dto.getCategory());
			pstmt.setString(2, dto.getSangpum());
			pstmt.setString(3, dto.getPhoto());
			pstmt.setInt(4, dto.getPrice());
			pstmt.setString(5, dto.getColor());
			pstmt.setString(6, dto.getIpgoday());
			
			//실행
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
		}
	}
	
	//전체 데이타 가져오기
	public List<ShopDto> getAllSangpums()
	{
		List<ShopDto> list=new ArrayList<ShopDto>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		Statement stmt=null;
		
		ResultSet rs=null;
		String sql="select * from shop order by shopnum desc";
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
//			stmt=conn.createStatement();
//			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				ShopDto dto=new ShopDto();
				dto.setShopnum(rs.getString("shopnum"));
				dto.setCategory(rs.getString("category"));
				dto.setSangpum(rs.getString("sangpum"));
				dto.setPhoto(rs.getString("photo"));
				dto.setPrice(rs.getInt("price"));
				dto.setColor(rs.getString("color"));
				dto.setIpgoday(rs.getString("ipgoday"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt, rs);
//			db.dbClose(conn, stmt, rs);
		}
		return list;
	}
	
	//한개 데이타 가져오기
	public ShopDto getData(String shopnum)
	{
		ShopDto dto=new ShopDto();
		Connection conn=null;
		Statement stmt=null;
		
		PreparedStatement pstmt=null;
		
		ResultSet rs=null;
		String sql="select * from shop where shopnum="+shopnum;
		//String sql="select * from shop where shopnum=?";
		conn=db.getMyConnection();
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			//pstmt=conn.prepareStatement(sql);
			//바인딩
//			pstmt.setString(1, shopnum);
//			rs=pstmt.executeQuery();
			if(rs.next())
			{
				dto.setShopnum(rs.getString("shopnum"));
				dto.setCategory(rs.getString("category"));
				dto.setSangpum(rs.getString("sangpum"));
				dto.setPhoto(rs.getString("photo"));
				dto.setPrice(rs.getInt("price"));
				dto.setColor(rs.getString("color"));
				dto.setIpgoday(rs.getString("ipgoday"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt, rs);
//			db.dbClose(conn, pstmt, rs);
		}
		return dto;
	}
	
	//cart insert
	public void insertCart(CartDto dto)
	{
		//SimpleDateFormat sdf=new SimpleDateFormat("YYYY-MM-DD HH:mm:ss");
		String sql="INSERT INTO CART VALUES (SEQ_MINI.NEXTVAL,"+dto.getShopnum()+","+dto.getNum()+",'"+dto.getMycolor()+"',"+dto.getCnt()+",sysdate)";
		
		/*
		 * String sql="insert into cart values (seq_mini.nextval," +"?,?,?,?,sysdate)";
		 */
		
		Connection conn=null;
		Statement stmt=null;
		
		PreparedStatement pstmt=null;
		
		conn=db.getMyConnection();
		try {
			//pstmt=conn.prepareStatement(sql);
			//바인딩
//			pstmt.setString(1, dto.getShopnum());
//			pstmt.setString(2, dto.getNum());
//			pstmt.setString(3, dto.getMycolor());
//			pstmt.setInt(4, dto.getCnt());
			
			stmt=conn.createStatement();
			stmt.execute(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt);
//			db.dbClose(conn, pstmt);
		}
	}
	
	//장바구니 출력
	public List<HashMap<String, String>> getCartList(String id)
	{
		String sql="SELECT c.idx,s.sangpum,s.shopnum,s.photo,s.price,c.cnt,c.mycolor,c.cartday FROM CART c, SHOP s,MEMBER m WHERE c.shopnum=s.shopnum and c.num=m.num and m.id=?";
		List<HashMap<String, String>> list=new ArrayList<HashMap<String,String>>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, id);
			//실행
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				HashMap<String, String> map=new HashMap<String, String>();
				map.put("idx", rs.getString("idx"));
				map.put("sangpum", rs.getString("sangpum"));
				map.put("shopnum", rs.getString("shopnum"));
				map.put("photo", rs.getString("photo"));
				map.put("price", rs.getString("price"));
				map.put("cnt", rs.getString("cnt"));
				map.put("mycolor", rs.getString("mycolor"));
				map.put("cartday", rs.getString("cartday").substring(0, 10));
				//list 에 추가
				list.add(map);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt, rs);
		}
		
		return list;
	}
	
	public void deleteCart(String idx)
	{
		String sql="DELETE FROM CART WHERE IDX="+idx;
		
		Connection conn=null;
		Statement stmt=null;
		
		PreparedStatement pstmt=null;
		
		//String sql="delete from cart where idx=?";
		
		conn=db.getMyConnection();
		
		try {
			
			stmt=conn.createStatement();
			
			//pstmt=conn.prepareStatement(sql);
			//바인딩
			//pstmt.setString(1, idx);
			//실행
			//pstmt.execute();
			
			stmt.execute(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt);
			//db.dbClose(conn, pstmt);
		}
	}
}
