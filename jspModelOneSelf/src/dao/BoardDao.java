package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BoardDto;

public class BoardDao {
	
	private static BoardDao dao = null;
	
	private BoardDao() {
	}
	
	public static BoardDao getInstance() {
		if(dao == null) {
			dao = new BoardDao();
		}
		return dao;
	}
	
	public List<BoardDto> getBoardList() {
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
				+ "           TITLE, CONTENT, WDATE, "
				+ "           DEL, READCOUNT "
				+ "    FROM BOARD "
				+ "    ORDER BY REF DESC, STEP ASC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;	
		
		List<BoardDto> list = new ArrayList<BoardDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBoardList success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/4 getBoardList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getBoardList success");
			
			while(rs.next()) {
				BoardDto dto = new BoardDto(rs.getInt(1), 
											rs.getString(2), 
											rs.getInt(3), 
											rs.getInt(4), 
											rs.getInt(5), 
											rs.getString(6), 
											rs.getString(7), 
											rs.getString(8), 
											rs.getInt(9), 
											rs.getInt(10));
				list.add(dto);
			}
			System.out.println("4/4 getBoardList success");
			
		} catch (SQLException e) {			
			e.printStackTrace();
			System.out.println("getBoardList fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}
	public boolean writeBoard(BoardDto dto) {
		String sql = " INSERT INTO BOARD "
				+ "      (SEQ, ID, "
				+ "      REF, STEP, DEPTH, "
				+ "      TITLE, CONTENT, WDATE, DEL, READCOUNT) "
				+ "    	 VALUES "
				+ "      (SEQ_BOARD.NEXTVAL, ?, "
				+ "		 (SELECT NVL(MAX(REF), 0)+1 FROM BOARD), 0, 0, "
				+ "      ?, ?, SYSDATE, 0, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 writeBoard success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("2/3 writeBoard success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 writeBoard success");
			
		} catch (SQLException e) {			
			e.printStackTrace();
			System.out.println("writeBoard fail");
		} finally {
			
			DBClose.close(conn, psmt, null);
		}
		
		return count>0?true:false;
	}
	
	public BoardDto getBoard(int seq) {
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, "
				+ "      TITLE, CONTENT, WDATE, DEL, READCOUNT "
				+ "    FROM BOARD "
				+ "    WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		BoardDto dto = null;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBoard success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/4 getBoard success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getBoard success");
			
			if(rs.next()) {
				dto = new BoardDto (rs.getInt(1), 
									rs.getString(2), 
									rs.getInt(3), 
									rs.getInt(4), 
									rs.getInt(5), 
									rs.getString(6), 
									rs.getString(7), 
									rs.getString(8), 
									rs.getInt(9), 
									rs.getInt(10));				
			}
			System.out.println("4/4 getBoard success");
			
		} catch (SQLException e) {			
			e.printStackTrace();
			System.out.println("BoardDto fail");
		} finally {
			
			DBClose.close(conn, psmt, rs);
		}		
		return dto;
	}
	public void readcount(int seq) {
		
		String sql = " UPDATE BOARD "
				+ "    SET READCOUNT=READCOUNT+1 "
				+ "    WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
				
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 readcount success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 readcount success");
			
			psmt.executeUpdate();
			System.out.println("3/3 readcount success");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("readcount fail");
		} finally {
			DBClose.close(conn, psmt, null);
		}		
	}
	
	public boolean answer(int seq, BoardDto info) {
		//update
		String sql1 =  " UPDATE BOARD "
				+ "     SET STEP=STEP+1 "
				+ "     WHERE REF = (SELECT REF FROM BOARD WHERE SEQ=? ) "
				+ "           AND STEP > (SELECT STEP FROM BOARD WHERE SEQ=? ) ";
		
		//insert
		String sql2 = " INSERT INTO BOARD(SEQ, ID, "
				+ "                       REF, STEP, DEPTH, "
				+ "                       TITLE, CONTENT, WDATE, DEL, READCOUNT) "
				+ "     VALUES(SEQ_BOARD.NEXTVAL, ?,"
				+ "                     (SELECT REF FROM BOARD WHERE SEQ=? ), "	// REF
				+ "                     (SELECT STEP FROM BOARD WHERE SEQ=? ) + 1, "	// STEP
				+ "                     (SELECT DEPTH FROM BOARD WHERE SEQ=? ) + 1, " // DEPTH
				+ "                     ?, ?, SYSDATE, 0, 0) ";  
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false);
			System.out.println("1/6 answer success");
			
			// update
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);
			System.out.println("2/6 answer success");
			
			count = psmt.executeUpdate();
			System.out.println("3/6 answer success");
			
			// psmt 초기화
			psmt.clearParameters();
			
			// insert
			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, info.getId());
			psmt.setInt(2, seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, info.getTitle());
			psmt.setString(6, info.getContent());
			System.out.println("4/6 answer success");
			
			count = psmt.executeUpdate();
			System.out.println("5/6 answer success");
			
			conn.commit();
			System.out.println("6/6 answer success");
			
		} catch (SQLException e) {			
				e.printStackTrace();
				System.out.println("answer fail");
					
				try {
					conn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();}	
					
					} finally {			
					try {
						conn.setAutoCommit(true);
					} catch (SQLException e) {
						e.printStackTrace();
					}
					DBClose.close(conn, psmt, null);
				}
				return count>0?true:false;		
	}
	public boolean deleteBoard(int seq) {
		String sql = " UPDATE BOARD "
				+ "    SET DEL=1 "
				+ "    WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;		
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteBoard success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 deleteBoard success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteBoard success");
			
		} catch (SQLException e) {			
			e.printStackTrace();
			System.out.println("deleteBoard fail");
		}
		
		return count>0?true:false;		
	}
	public boolean updateBoard(int seq, BoardDto dto) {
		String sql = " UPDATE BOARD "
				+ " SET TITLE=?, "
				+ "	CONTENT=? "
				+ " WHERE SEQ=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 updateBoard success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			System.out.println("2/3 updateBoard success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 updateBoard success");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("updateBoard fail");
		}
		return count>0?true:false;		
	}
	public int getAllBoard(String choice, String search) {
		
		String sql = " SELECT COUNT(*) FROM BOARD ";
		
		String sWord = "";
		if(choice.equals("title")) {
			sWord = " WHERE TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) {
			sWord = " WHERE CONTENT LIKE '%" + search + "%' ";
		}else if(choice.equals("id")) {
			sWord = " WHERE ID= '" + search + "' ";
		}		
		sql = sql + sWord;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int len = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getAllBoard success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getAllBoard success");
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				len = rs.getInt(1);
			}
			System.out.println("3/3 getAllBoard success");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("getAllBoard fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return len;
	}
	public List<BoardDto> getBoardPagingList(String choice, String search, int pageNumber) {
		
		String sql = " SELECT SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT "
				+ "    FROM ";
		
			   sql+= 		"(SELECT ROW_NUMBER()OVER(ORDER BY REF DESC, STEP ASC) AS RNUM, "
			   		+ "			SEQ, ID, REF, STEP, DEPTH, TITLE, CONTENT, WDATE, DEL, READCOUNT "
			   		+ "	      FROM BOARD";	
		
		String sWord = "";
		if(choice.equals("title")) {
			sWord = "         WHERE TITLE LIKE '%" + search + "%' ";
		}else if(choice.equals("content")) {
			sWord = "         WHERE CONTENT LIKE '%" + search + "%' ";
		}else if(choice.equals("id")) {
			sWord = "         WHERE ID= '" + search + "' ";
		}		
		sql = sql + sWord;
		
		sql = sql + "         ORDER BY REF DESC, STEP ASC) ";
		
		sql = sql + " WHERE RNUM >= ? AND RNUM <= ? ";
//		sql = sql + " WHERE RNUM BETWEEN ? AND ? ";	
		
		// pageNumber = 0 1 2
		int start, end;
		start = 1 + 10 * pageNumber;
		end = 10 + 10 * pageNumber;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<BoardDto> list = new ArrayList<BoardDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBoardList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			System.out.println("2/4 getBoardList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/4 getBoardList success");
			
			while(rs.next()) {
				BoardDto dto = new BoardDto(rs.getInt(1), 
											rs.getString(2), 
											rs.getInt(3), 
											rs.getInt(4), 
											rs.getInt(5), 
											rs.getString(6), 
											rs.getString(7), 
											rs.getString(8), 
											rs.getInt(9), 
											rs.getInt(10));
				list.add(dto);
			}
			System.out.println("4/4 getBoardList success");
			
		} catch (SQLException e) {			
			e.printStackTrace();
			System.out.println("getBoardList fail");
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return list;
	}
}
