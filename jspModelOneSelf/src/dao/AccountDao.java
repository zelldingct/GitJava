package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.AccountDto;

public class AccountDao {
	
	private static AccountDao dao = null;

	private AccountDao() {
		DBConnection.initConnection();
	}
	
	public static AccountDao getInstance() {
		if(dao == null) {
			dao = new AccountDao();
		}
		return dao;
	}
	public AccountDto login(String id, String pwd) {
		String sql = " SELECT ID, NAME, EMAIL, AUTH " //sql 명령문
				+ "	FROM ACCOUNT "
				+ " WHERE ID=? AND PWD=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		AccountDto acc = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 login success");
			//sysout을 적어줌으로써 어디에 오류가 발생하는지 쉽게 찾을 수 있다.
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);//매개변수 잘보고 쓰기
			psmt.setString(2, pwd);
			System.out.println("2/3 login success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 login success");
			
			if(rs.next()) {
				String id1 = rs.getString(1);
				String name = rs.getString(2);
				String email = rs.getString(3);
				int auth = rs.getInt(4);
				
				acc = new AccountDto(id1, null, name, email, auth); 
				//입력한 id와 pwd를 기반으로 pwd를 제외한 데이터를 갖고 온다.
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("login fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return acc;
				
	}

	public boolean addAccount(AccountDto dto) {
		String sql = "	INSERT INTO ACCOUNT(ID, PWD, NAME, EMAIL, AUTH)		"
				+ "		VALUES(?, ?, ?, ?, 3)	"; //ACCOUNT TABLE에 데이터 삽입 쿼리
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addAccount success");
			//테이블에 삽입할 signup에서 입력된 데이터를 가져온다.
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());//매개변수에 주의한다.
			psmt.setString(2, dto.getPwd());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			System.out.println("2/3 addAccount success");
			
			count = psmt.executeUpdate();//update실행
			System.out.println("3/3 addAccount success");			
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("addAccount fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}
	
		return count>0?true:false;//실행되었다면 true 아니라면 false
	}
	
	public boolean getId(String id) {
		
		String sql = " SELECT COUNT(*) "
				+ " FROM ACCOUNT "
				+ " WHERE ID=? ";
		//id가 있다면 1 없다면 0
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int findId = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			System.out.println("2/3 getId success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getId success");
			
			if(rs.next()) {
				findId = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getId fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return findId>0?true:false; //id 있으면 true 없으면 false
	
	}
}
