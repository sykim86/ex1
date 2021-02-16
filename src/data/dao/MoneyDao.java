package data.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Vector;

import data.dto.MoneyDto;
import oracle.db.DbConnect;

public class MoneyDao {
	DbConnect db=new DbConnect();
	
	public List<MoneyDto> getAllMoneys()
	{
		List<MoneyDto> list=new Vector<MoneyDto>();
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		String sql="select * from daymoney order by num asc";
		
		conn=db.getMyConnection();
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				MoneyDto dto=new MoneyDto();
				dto.setNum(rs.getInt("num"));
				dto.setPummok(rs.getString("pummok"));
				dto.setPrice(rs.getInt("price"));
				dto.setDay(rs.getString("day"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt, rs);
		}
		
		return list;
	}
	
	public void insertDaymoney(MoneyDto dto)
	{
		String sql="insert into daymoney values (seq_money.nextval,'"+dto.getPummok()+"',"+dto.getPrice()+",'"+dto.getDay()+"')";
		
		Connection conn=null;
		Statement stmt=null;
		conn=db.getMyConnection();
		
		try {
			stmt=conn.createStatement();
			
			stmt.execute(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt);
		}
	}
	
	//num 에 해당하는 dto 반환
	public MoneyDto getData(String num)
	{
		MoneyDto dto=new MoneyDto();
		
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		
		String sql="select * from daymoney where num="+num;
		
		conn=db.getMyConnection();
		
		try {
			stmt=conn.createStatement();
			
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				dto.setNum(rs.getInt("num"));
				dto.setPummok(rs.getString("pummok"));
				dto.setPrice(rs.getInt("price"));
				dto.setDay(rs.getString("day"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt, rs);
		}
		
		return dto;
	}
	
	//수정
	public void updateDaymoney(MoneyDto dto)
	{
		String sql="update daymoney set pummok='"+dto.getPummok()+"',price="+dto.getPrice()+",day='"+dto.getDay()+"' where num="+dto.getNum();
		
		Connection conn=null;
		
		Statement stmt=null;
		
		conn=db.getMyConnection();
		
		try {
			stmt=conn.createStatement();
			//실행
			stmt.execute(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt);
		}
	}
	
	//삭제
	public void deleteDaymoney(String num)
	{
		String sql="delete from daymoney where num="+num;
		
		Connection conn=null;
		Statement stmt=null;
		
		conn=db.getMyConnection();
		
		try {
			stmt=conn.createStatement();
			stmt.execute(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(conn, stmt);
		}
	}
}
