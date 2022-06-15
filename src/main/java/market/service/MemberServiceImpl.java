package market.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import market.dao.MemberDAO;
import market.dao.MemberDAOImpl;
import market.model.MemberDTO;

@Service
public class MemberServiceImpl {
	@Autowired
	private MemberDAOImpl md;

	public int memberInsert(MemberDTO member) throws Exception {
		System.out.println("insert 서비스까지왔구나");
		return md.memberInsert(member);
	}
	//회원가입 중 이메일중복검사
	public int memberEmailCheck(String m_email)throws Exception{
		return md.memberEmailCheck(m_email);
	}
	public MemberDTO loginCheck(String m_email) throws Exception {
		System.out.println("로그인인증 슝");
		return md.loginCheck(m_email);
	}
	public MemberDTO select(String m_email) throws Exception{
		System.out.println("email: "+m_email);
		
		return md.select(m_email);
	}
	//비밀번호찾기
	public MemberDTO passwdSearch(MemberDTO member)throws Exception{
		return md.passwdSearch(member);
	}
	//임시비밀번호로 수정 
	public int passwdUpdate(MemberDTO member)throws Exception{
		return md.passwdUpdate(member);
	}
	//이메일찾기
	public MemberDTO emailSearch(MemberDTO member)throws Exception{
		return md.emailSearch(member);
	}
	public int memberConfirmForm(MemberDTO member)throws Exception{
	 return md.memberConfirmForm(member); 
  }
	public int memberUpdate(MemberDTO member)throws Exception{
		return md.memberUpdate(member);
	}
	public int memberConfirm(MemberDTO member)throws Exception{
		return md.memberConfirm(member);
	}
	
	public int deleteMember(MemberDTO member)throws Exception{
		return md.deleteMember(member);
	}
	public List<MemberDTO> memberList()throws Exception{
		return md.memberList();
	}
	public int memberListCheck(String email)throws Exception{
		return md.memberListCheck(email);
	}
	//총 데이터 갯수 구하기 
		public int getTotal(MemberDTO member)throws Exception{
			return md.getTotal(member);
		}
		//카카오로그인할때 db에 이메일저장 
		public int kakaologin(MemberDTO kakao)throws Exception{
			return md.kakaologin(kakao);
		}	
		//네이버로 로그인할때 db에 이메일과 이름 저장 
		public int naverlogin(MemberDTO naver)throws Exception{
			return md.naverlogin(naver);
		}	
	}
