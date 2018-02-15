// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   DecodeEncryptor168.java

package stm.com.support.util;

import java.io.IOException;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;

import sun.misc.BASE64Decoder;

public class DecodeEncryptor168 {

	public DecodeEncryptor168() {
	}

	public static byte[] decode(String encrypted) {
		System.out.println((new StringBuilder()).append("encrypted : ").append(encrypted).toString());
		try {
			return (new BASE64Decoder()).decodeBuffer(encrypted);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}

	public static String decodeRandomKey(String randomKey) {
		String ciphers = "aBcDeFgHiJ";
		String key = "";
		for (int i = 0; i < randomKey.length(); i++) {
			int index = ciphers.indexOf(randomKey.substring(i, i + 1));
			if (index < 0)
				key = key.concat(".");
			else
				key = key.concat(String.valueOf(index));
		}

		return key;
	}

	public static String findRandomKey(String encrypted) {
		return encrypted.substring(encrypted.lastIndexOf(".") - 1);
	}

	public static String findOriginData(String encrypted) {
		return encrypted.substring(0, encrypted.lastIndexOf(".") - 1);
	}

	public static String decrypt(byte keydata[], byte data[]) {
		try {
			DESedeKeySpec keySpec = new DESedeKeySpec(keydata);
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
			javax.crypto.SecretKey desKey = keyFactory.generateSecret(keySpec);
			Cipher cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
			cipher.init(2, desKey);
			byte decryptedText[] = cipher.doFinal(data);
			String output = new String(decryptedText, "UTF8");
			System.out.println((new StringBuilder()).append("output : ").append(output).toString());
			return output;
		} catch (Exception e) {
			return null;
		}
	}

	public static String getDecryptedValue(String encrypted) {
		String decrypted = "";
		try {
			String customKey = (new StringBuilder()).append("kips.korea.ac.kr163.152.6.38").append(decodeRandomKey(findRandomKey(encrypted))).toString();
			decrypted = decrypt(customKey.getBytes(), decode(findOriginData(encrypted)));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return decrypted;
	}

	public static void main(String args[]) {
		DecodeEncryptor168 encryptor168 = new DecodeEncryptor168();
		String encrypted = "IOJrGDGHemMUJWKoDgxQCRRpbs8mo6MuyFnrO7iNrbOeHEXXvln4dQ20LLUP/eYMLIgm7m0pd0haHjFh4tdEqaUzo3MQsYajStzvya6OHY69v20iCRPbmQ==a.iFcDaacHigaBeHiJ";
		DecodeEncryptor168 _tmp = encryptor168;
		String decrypted = getDecryptedValue(encrypted);
		System.out.println((new StringBuilder()).append("decrypt data : ").append(decrypted).toString());
	}

	private static final String KEY = "kips.korea.ac.kr163.152.6.38";
}
