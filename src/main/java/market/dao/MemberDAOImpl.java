package market.dao;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import market.model.MemberDTO;
import market.model.ShopDTO;
import scala.collection.mutable.HashMap;

@Repository
public class MemberDAOImpl {

	@Autowired
	private SqlSession sqlSession;

	// 회원저장
	public int memberInsert(MemberDTO member) throws Exception {
		return sqlSession.insert("memberns.insertMember", member);
	}
	//이메일 중복검사 
	public int memberEmailCheck(String m_email)throws Exception{
		
		int result = -1;  //사용가능아이디 
		
		MemberDTO member = sqlSession.selectOne("memberns.memberEmailCheck", m_email);
				if(member != null)
					result = 1; 	//중복아이디
				
				return result; 
	}

	// 로그인인증
	public MemberDTO loginCheck(String m_email) throws Exception {
		System.out.println("로긴체크 dao도착");
		System.out.println("m_email: " + m_email);
		return sqlSession.selectOne("memberns.loginCheck", m_email);
	}

	// 회원정보가져오기
	public MemberDTO select(String m_email) throws Exception {
		return sqlSession.selectOne("memberns.select", m_email);
	}

	// 회원확인폼
	public int memberConfirmForm(MemberDTO member) throws Exception {
	return sqlSession.update("memberns.memberConfirmForm", member);
	}

	//회원확인
	public int memberConfirm(MemberDTO member)throws Exception{
		return sqlSession.update("memberns.memberConfirm", member);
	}
	//회원정보수정
	public int memberUpdate(MemberDTO member)throws Exception{
		return sqlSession.update("memberns.memberUpdate",member);
	}

	// 비밀번호찾기
	public MemberDTO passwdSearch(MemberDTO member) throws Exception {
		return sqlSession.selectOne("memberns.passwdSearch", member);
	}
	//임시비밀번호로 수정 
	public int passwdUpdate(MemberDTO member)throws Exception {
		return sqlSession.update("memberns.passwdUpdate", member);
		
	}
	//아이디(이메일찾기)
	public MemberDTO emailSearch(MemberDTO member)throws Exception{
		List<MemberDTO> list = sqlSession.selectList("memberns.emailSearch", member);
		System.out.println(list.get(0));
		return (MemberDTO)list.get(0);
	}
	//회원삭제
	public int deleteMember(MemberDTO member)throws Exception{
		return sqlSession.update("memberns.deleteMember", member);
	}
	//회원목록출력
	public List<MemberDTO> memberList()throws Exception{
		return sqlSession.selectList("memberns.memberList");
	}
	//총 회원 수 구하기 
	 public int getTotal(MemberDTO member)throws Exception{
			return sqlSession.selectOne("memberns.getTotal",member);
		}
	//체크박스로 회원강제탈퇴
	public int memberListCheck(String email)throws Exception{
		return sqlSession.update("memberns.memberListCheck", email);
	}
	//카카오로그인시 email DB저장
	public int kakaologin(MemberDTO kakao)throws Exception{
		return sqlSession.insert("memberns.kakaoinsert",kakao);
	}
	//네이버로 로그인할때 db에 이메일과 이름 저장 
		public int naverlogin(MemberDTO naver)throws Exception{
			return sqlSession.insert("memberns.naverinsert",naver);
		}	
	
}