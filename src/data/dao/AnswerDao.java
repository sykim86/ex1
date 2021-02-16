package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import data.dto.AnswerDto;
import oracle.db.DbConnect;

public class AnswerDao {
	DbConnect db=new DbConnect();
	
	//insert
	public void insertAnswer(AnswerDto dto)
	{
		String sql="insert into answer values (seq_mini.nextval,?,?,?,sysdate)";
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, dto.getNum());
			pstmt.setString(2, dto.getMyid());
			pstmt.setString(3, dto.getMemo());
			//실행
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
		}
		
	}
	
	public List<AnswerDto> getAnswerList(String num)
	{
//		List<AnswerDto> list=new ArrayList<AnswerDto>();
		List<AnswerDto> list=new Vector<AnswerDto>();
		
		String sql="select * from answer where num="+num+" order by idx desc";
		
		//String sql="select * from answer where num=?";
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		PreparedStatement pstmt=null;
		
		conn=db.getMyConnection();
		
		try {
//			pstmt=conn.prepareStatement(sql);
//			//바인딩
//			pstmt.setString(1, num);
//			//실행
//			rs=pstmt.executeQuery();
			
			stmt=conn.createStatement();
			
			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				AnswerDto dto=new AnswerDto();
				dto.setIdx(rs.getString("idx"));
				dto.setNum(rs.getString("num"));
				dto.setMyid(rs.getString("myid"));
				dto.setMemo(rs.getString("memo"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				//list 에 추가
				list.add(dto);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt, rs);
//			db.dbClose(conn, pstmt, rs);
		}
		
		return list;
	}
	
	public void deleteAnswer(String idx)
	{
		String sql="delete from answer where idx=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		conn=db.getMyConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			//바인딩
			pstmt.setString(1, idx);
			//실행
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, pstmt);
		}
		
	}
	
	public String getMemo(String idx)
	{
		String sql="select memo from answer where idx="+idx;
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		conn=db.getMyConnection();
		String memo="";
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			if(rs.next())
			{
				memo=rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt, rs);
		}
		
		return memo;
	}
	
	public void updateAnswer(String idx,String memo)
	{
		String sql="update answer set memo='"+memo+"' where idx="+idx;
		
		//String sql="update answer set memo=? where idx=?";
		
		PreparedStatement pstmt=null;
		
		Connection conn=null;
		Statement stmt=null;
		
		conn=db.getMyConnection();
		
		try {
			//pstmt=conn.prepareStatement(sql);
			//바인딩
			//pstmt.setString(1, memo);
			//pstmt.setString(2, idx);
			//실행
			//pstmt.execute();
			
			stmt=conn.createStatement();
			
			stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
//			db.dbClose(conn, pstmt);
			db.dbClose(conn, stmt);
		}
	}
}
