package oracle.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DbConnect {
	String driver="oracle.jdbc.driver.OracleDriver";
	String gangsa_url="jdbc:oracle:thin:@192.168.0.12:1521:orcl";
	String my_url="jdbc:oracle:thin:@localhost:1521:orcl";
	String gangsa_id="angel";
	String my_id="angel";
	String gangsa_pass="a1234";
	String my_pass="a1234";
	
	public DbConnect() {
		// TODO Auto-generated constructor stub
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("����Ŭ ����̹� ����:"+e.getMessage());
		}
	}
	
	//����pc ����Ŭ ����
	public Connection getGangsaConnection() {
		Connection conn=null;
		try {
			conn=DriverManager.getConnection(gangsa_url, gangsa_id, gangsa_pass);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("���� pc ����Ŭ ���� ����"+e.getMessage());
		}
		return conn;
	}
	
	//��pc ����Ŭ ����
	public Connection getMyConnection() {
		Connection conn=null;
		try {
			conn=DriverManager.getConnection(my_url, my_id, my_pass);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("�� pc ����Ŭ ���� ����"+e.getMessage());
		}
		return conn;
	}
	
	public void dbClose(Connection conn,Statement stmt)
	{
		try {
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public void dbClose(Connection conn,PreparedStatement pstmt)
	{
		try {
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public void dbClose(Connection conn,Statement stmt,ResultSet rs)
	{
		try {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(conn!=null) conn.close();
		}catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	public void dbClose(Connection conn,PreparedStatement pstmt,ResultSet rs)
	{
		try {
			if(rs!=null) rs.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		}catch (Exception e) {
			// TODO: handle exception
		}
	}
}
