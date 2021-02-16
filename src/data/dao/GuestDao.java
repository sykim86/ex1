package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import data.dto.GuestDto;
import oracle.db.DbConnect;

public class GuestDao {
	DbConnect db=new DbConnect();
	
	public void insertGuest(GuestDto dto)
	{
		String sql="insert into guest values (seq_guest.nextval,'"+dto.getMyid()+"','"+dto.getPhoto()+"','"+dto.getContent()+"',sysdate)";
		
		//String sql="insert into guest values (seq_guest.nextval,?,?,?,sysdate)";
		
		Connection conn=null;
		Statement stmt=null;
		
		PreparedStatement pstmt=null;
		
		conn=db.getMyConnection();
		
		try {
			//pstmt=conn.prepareStatement(sql);
			
			//바인딩
//			pstmt.setString(1, dto.getMyid());
//			pstmt.setString(2, dto.getPhoto());
//			pstmt.setString(3, dto.getContent());
			
			//실행
//			pstmt.execute();
			
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
	
	public int getTotalCount()
	{
		int total=0;
		//int n=0;
		
		String sql="select count(*) from guest";
		
		Connection conn=null;
		Statement stmt=null;
		
		PreparedStatement pstmt=null;
		
//		String sql="select count(*) from guest";
		
		ResultSet rs=null;
		
		conn=db.getMyConnection();
		
		try {
//			pstmt=conn.prepareStatement(sql);
			stmt=conn.createStatement();
//			rs=pstmt.executeQuery();
			rs=stmt.executeQuery(sql);
			if(rs.next())
			{
				//total=rs.getInt("count(*)");
//				n=rs.getInt(1);
				total=rs.getInt(1);
			}
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt, rs);
//			db.dbClose(conn, pstmt, rs);
		}
		
		return total;
	}
	
	//페이징처리한 리스트 목록 반환
	public List<GuestDto> getList(int start,int end)
	{
		List<GuestDto> list=new ArrayList<GuestDto>();
		String sql="select a.* from (select ROWNUM as RNUM,b.* from (select * from guest order by num desc)b)a where a.RNUM>=? and a.RNUM<=?";
		
//		String sql="select b.* (select * from guest order by num desc)b";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			//실행
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				GuestDto dto=new GuestDto();
				dto.setNum(rs.getString("num"));
				dto.setMyid(rs.getString("myid"));
				dto.setContent(rs.getString("content"));
				dto.setPhoto(rs.getString("photo"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				//list 에 추가
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt, rs);
		}
		return list;
	}
	
	public GuestDto getData(String num)
	{
		GuestDto dto=new GuestDto();
		
		String sql="select * from guest where num="+num;
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		conn=db.getMyConnection();
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next())
			{
				dto.setNum(rs.getString("num"));
				dto.setMyid(rs.getString("myid"));
				dto.setPhoto(rs.getString("photo"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt, rs);
		}
		
		return dto;
	}
	
	//photo 는 null 이 아닐경우만 수정,content 만 수정
	public void updateGuest(GuestDto dto)
	{
		String sql="";
		
		Connection conn=null;
		Statement stmt=null;
		
		PreparedStatement pstmt=null;
		
		conn=db.getMyConnection();
		
		try {
			
			if(dto.getPhoto()==null)
			{
				sql="update guest set content='"+dto.getContent()+"' where num="+dto.getNum();
				stmt=conn.createStatement();
				stmt.execute(sql);
			}
			else
			{
				
				sql="update guest set photo='"+dto.getPhoto()+"',content='"+dto.getContent()+"' where num="+dto.getNum();
				stmt=conn.createStatement();
				stmt.execute(sql);
			}
			
//			if(dto.getPhoto()==null)
//			{
//				sql="update guest set content=? where num=?";
//				pstmt=conn.prepareStatement(sql);
//				//바인딩
//				pstmt.setString(1, dto.getContent());
//				pstmt.setString(2, dto.getNum());
//				
//			}
//			else
//			{
//				sql="update guest set photo=?,content=? where num=?";
//				pstmt=conn.prepareStatement(sql);
//				//바인딩
//				pstmt.setString(1, dto.getPhoto());
//				pstmt.setString(2, dto.getContent());
//				pstmt.setString(3, dto.getNum());
//			}
			//실행
//			pstmt.execute();
			
		} catch (SQLException e) {
		
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt);
//			db.dbClose(conn, pstmt);
		}
		
	}
	
	//삭제
	public void deleteGuest(String num)
	{
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		Statement stmt=null;
		
		String sql="delete from guest where num=?";
		
//		String sql="delete from guest where num"+num;
		
		conn=db.getMyConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			
//			stmt=conn.createStatement();
//			stmt.execute(sql);
			
			//바인딩
			pstmt.setString(1, num);
			//실행
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
//			db.dbClose(conn, stmt);
		}
	}
}
