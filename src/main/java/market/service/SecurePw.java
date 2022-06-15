package market.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class SecurePw {
	
	private static final int salt_size = 16;

	// 입력받은 비밀번호 해싱 메소드
	public static String hashing(byte[] passwd, String salt) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		// 키스트레칭 10000번
		for (int i = 0; i < 10000; i++) {
			String temp = byteToString(passwd) + salt;
			md.update(temp.getBytes());
			passwd = md.digest();
		}

		return byteToString(passwd);
	}

	// byte를 String 변환 메소드
	private static String byteToString(byte[] item) {
		StringBuilder sb = new StringBuilder();

		// byte를 String으로 변환(16진수)
		for (byte i : item) {
			sb.append(String.format("%02x", i));

		}
		return sb.toString();
	}

	// SecureRandom 객체를 통해 salt값 호출 메소드
	public static String getSalt() {
		SecureRandom random = new SecureRandom();

		byte[] salt = new byte[salt_size];
		// nextBytes(): SecureRandom에서 난수를 생성하는 메서드,
		// 파라미터에는 생성된 난수를 담을 byte 배열을 입력한다.
		random.nextBytes(salt);
		return byteToString(salt);

	}

}
