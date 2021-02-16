package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import data.dto.ShopAnswerDto;
import oracle.db.DbConnect;

public class ShopAnswerDao {
	DbConnect db=new DbConnect();
	
	//insert
	public void insertAnswer(ShopAnswerDto dto)
	{
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="insert into shopanswer (idx,shopnum,myid,content,writeday)"
				+ " values (seq_mini.nextval,?,?,?,sysdate)";
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, dto.getShopnum());
			pstmt.setString(2, dto.getMyid());
			pstmt.setString(3, dto.getContent());
			
			//실행
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
		}
	}
	
	//select
	public List<ShopAnswerDto> getAnswerList(String shopnum)
	{
		List<ShopAnswerDto> list=new ArrayList<ShopAnswerDto>();
		
		String sql="select * from shopanswer where shopnum=? order by idx desc";
		
		//int shopnum=Integer.parseInt(shopnum);
		//String sql="select * from shopanswer where shopnum="+shopnum+
		
		Connection conn=null;
		Statement stmt=null;
		
		PreparedStatement pstmt=null;
		
		ResultSet rs=null;
		
		conn=db.getMyConnection();
		
		try {
			//stmt=conn.createStatement();
			pstmt=conn.prepareStatement(sql);
			
			//바인딩
			pstmt.setString(1, shopnum);
			
			//rs=stmt.executeQuery(sql);
			
			//실행
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				ShopAnswerDto dto=new ShopAnswerDto();
				
				dto.setIdx(rs.getString("idx"));
				dto.setShopnum(rs.getString("shopnum"));
				dto.setMyid(rs.getString("myid"));
				dto.setContent(rs.getString("content"));
				dto.setShopanswer(rs.getString("shopanswer"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt, rs);
			//db.dbClose(conn, stmt, rs);
		}
		
		return list;
	}
	
	//샵주인의 답글
	public void updateShopAnswer(String idx,String answer)
	{
		String sql="update shopanswer set shopanswer=? where idx=?";
		
		//String sql="update shopanswer set shopanswer='"+answer+"' where idx="+idx;
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		Statement stmt=null;
		
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			
			//stmt=conn.createStatement();
			
			//바인딩
			pstmt.setString(1, answer);
			pstmt.setString(2, idx);
			//실행
			pstmt.execute();
			
			//stmt.execute(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
			//db.dbClose(conn, stmt);
		}
	}
	
	//삭제
	public void deleteAnswer(String idx)
	{
		Connection conn=null;
		Statement stmt=null;
		
		PreparedStatement pstmt=null;
		
		String sql="delete from shopanswer where idx="+idx;
		
		//String sql="delete from shopanswer where idx=?";
		
		conn=db.getMyConnection();
		
		try {
			stmt=conn.createStatement();
			
			//pstmt=conn.prepareStatement(sql);
			//바인딩
			//pstmt.setString(1, idx);
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
