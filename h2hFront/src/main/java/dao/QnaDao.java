package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import vo.QnaList;

@Repository
public class QnaDao {
    private final JdbcTemplate jdbc;

    public QnaDao(DataSource dataSource) {
        this.jdbc = new JdbcTemplate(dataSource);
    }
    public int getQnaListCount(String where) {
    	// 검색된(검색어가 있을 경우) 게시글의 총 개수를 리턴하는 메소드
    		String sql = "select count(*) from t_qna_list " + where;
    		int rcnt = jdbc.queryForObject(sql, Integer.class);
    		return rcnt;
    	}

    
    public List<QnaList> getQnaList(String where, int cpage, int psize) {
        String sql = "SELECT ql_idx, ql_ctgr, ql_title, ql_qdate, mi_id, ql_isanswer FROM t_qna_list " + where +
                " ORDER BY ql_idx DESC LIMIT " + ((cpage - 1) * psize) + ", " + psize;
        List<QnaList> qnaList = jdbc.query(sql, new RowMapper<QnaList>() {
            @Override
            public QnaList mapRow(ResultSet rs, int rowNum) throws SQLException {
                QnaList ql = new QnaList();
                ql.setQl_idx(rs.getInt("ql_idx"));
                ql.setQl_ctgr(rs.getString("ql_ctgr"));
                ql.setMi_id(rs.getString("mi_id"));
                ql.setQl_title(rs.getString("ql_title"));
                ql.setQl_qdate(rs.getString("ql_qdate"));
                ql.setQl_isanswer(rs.getString("ql_isanswer"));
                return ql;
            }
        });

        return qnaList;
    }

	public int qnaInsert(QnaList ql) {
		String sql = "INSERT INTO t_qna_list (ql_ctgr, ql_title, ql_content, ql_img1, ql_img2) " +
                "VALUES (?, ?, ?, ?, ?)";
		int result = jdbc.update(sql, ql.getQl_ctgr(), ql.getQl_title(), ql.getQl_content(), ql.getQl_img1(), ql.getQl_img2());   
		return result;
	}
	public QnaList getQnaList(int qlidx) {
		// TODO Auto-generated method stub
		return null;
	}
}
